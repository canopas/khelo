"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
exports.fiveMinuteCron = exports.teamPlayerChangeObserver = exports.TIMEZONE = void 0;

const app_1 = require("firebase-admin/app");
const firestore_1 = require("firebase-admin/firestore");
const firestore_2 = require("firebase-functions/v2/firestore");
const scheduler = require("firebase-functions/v2/scheduler");

const team_repository = require("./team/team_repository");
const user_repository = require("./user/user_repository");
const match_repository = require("./match/match_repository");
const mail_repository = require("./mail/mail_repository");

const notification_service = require("./notification/notification_service");
const team_service = require("./team/team_service");
const match_service = require("./match/match_service");

const logger = require("firebase-functions/logger");

exports.TIMEZONE = "Asia/Kolkata";
const REGION = "asia-south1";
const app = (0, app_1.initializeApp)();
const db = (0, firestore_1.getFirestore)(app);
const { onCall } = require("firebase-functions/v2/https");

const userRepository = new user_repository.UserRepository(db);
const teamRepository = new team_repository.TeamRepository(db);
const mailRepository = new mail_repository.MailRepository(db);

const notificationService = new notification_service.NotificationService(userRepository);
const teamService = new team_service.TeamService(userRepository, notificationService);
const matchService = new match_service.MatchService(userRepository, teamRepository, notificationService);

const matchRepository = new match_repository.MatchRepository(db, matchService);

exports.teamPlayerChangeObserver = (0, firestore_2.onDocumentUpdated)({ region: REGION, document: "teams/{teamId}" }, async (event) => {
  const snapshot = event.data;
  if (!snapshot) {
    (0, logger.error)("No data associated with the event");
    return;
  }
  const oldTeam = snapshot.before.data();
  const newTeam = snapshot.after.data();

  await teamService.notifyOnAddedToTeam(oldTeam, newTeam);
});

exports.fiveMinuteCron = (0, scheduler.onSchedule)({ timeZone: exports.TIMEZONE, schedule: "*/5 * * * *" }, async () => {
  await matchRepository.processUpcomingMatches();
});

exports.sendSupportRequest = onCall({ region: "asia-south1" }, async (request) => {
  const data = request.data;
  await mailRepository.sendSupportRequest(data);
});