"use strict";

Object.defineProperty(exports, "__esModule", {value: true});
exports.fiveMinuteCron = exports.apiv1 = exports.teamPlayerChangeObserver = exports.userStatWriteObserver = exports.TIMEZONE = void 0;

const express = require("express");

const app_1 = require("firebase-admin/app");
const firestore_1 = require("firebase-admin/firestore");
const firestore_2 = require("firebase-functions/v2/firestore");
const scheduler = require("firebase-functions/v2/scheduler");
const callable = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");

const team_repository = require("./team/team_repository");
const user_repository = require("./user/user_repository");
const match_repository = require("./match/match_repository");
const leaderboard_repository = require("./leaderboard/leaderboard_repository");

const notification_service = require("./notification/notification_service");
const team_service = require("./team/team_service");
const match_service = require("./match/match_service");
const auth_service = require("./auth/auth_service");
const leaderboard_service = require("./leaderboard/leaderboard_service");

exports.TIMEZONE = "Asia/Kolkata";
const REGION = "asia-south1";
const app = (0, app_1.initializeApp)();
const db = (0, firestore_1.getFirestore)(app);

const userRepository = new user_repository.UserRepository(db);
const teamRepository = new team_repository.TeamRepository(db);
const leaderboardRepository = new leaderboard_repository.LeaderboardRepository(db);

const notificationService = new notification_service.NotificationService(userRepository);
const teamService = new team_service.TeamService(userRepository, notificationService);
const matchService = new match_service.MatchService(userRepository, teamRepository, notificationService);
const authService = new auth_service.AuthService(userRepository);
const leaderboardService = new leaderboard_service.LeaderboardService(leaderboardRepository);

const matchRepository = new match_repository.MatchRepository(db, matchService);

const expressApp = express();
expressApp.use((0, user_repository.firebaseAuthMiddleware)(userRepository));
// Log errors in responses
expressApp.use((req, res, next) => {
  const oldSend = res.send;
  res.send = (body) => {
    if (res.statusCode < 200 || res.statusCode >= 300) {
      (0, logger.error)(`${req.path}, ${res.statusCode}, ${body}`);
    }
    return oldSend.call(res, body);
  };
  next();
});

expressApp.post("/user/create", (req, res) => {
  authService.onCallCreateAuthUser(req, res);
});

exports.teamPlayerChangeObserver = (0, firestore_2.onDocumentUpdated)({region: REGION, document: "teams/{teamId}"}, async (event) => {
  const snapshot = event.data;
  if (!snapshot) {
    (0, logger.error)("No data associated with the event");
    return;
  }
  const oldTeam = snapshot.before.data();
  const newTeam = snapshot.after.data();

  await teamService.notifyOnAddedToTeam(oldTeam, newTeam);
});

exports.userStatWriteObserver = (0, firestore_2.onDocumentWritten)({region: REGION, document: "users/{userId}/user_stat/{type}"}, async (event) => {
  const snapshot = event.data;
  if (!snapshot) {
    (0, logger.error)("No data associated with the event");
    return;
  }

  const oldStat = snapshot?.before?.data();
  const newStat = snapshot?.after?.data();

  const {userId} = event.params;

  if (newStat) {
    await leaderboardService.updateLeaderboard(userId, oldStat, newStat);
  }
});

exports.fiveMinuteCron = (0, scheduler.onSchedule)({timeZone: exports.TIMEZONE, schedule: "*/5 * * * *", region: REGION}, async () => {
  await matchRepository.processUpcomingMatches();
});

exports.apiv1 = (0, callable.onRequest)({region: REGION, concurrency: 100, cors: true}, expressApp);
