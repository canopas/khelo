"use strict";
Object.defineProperty(exports, "__esModule", {value: true});
exports.MatchRepository = void 0;
const admin = require("firebase-admin");

class MatchRepository {
  constructor(db, matchService) {
    this.db = db;
    this.matchService = matchService;
  }
  matchRef() {
    return this.db.collection("matches");
  }
  getAdminTimestampWithZeroSeconds() {
    const now = new Date();
    now.setSeconds(0);
    now.setMilliseconds(0);
    return admin.firestore.Timestamp.fromDate(now);
  }
  async processUpcomingMatches() {
    const NOTIFICATION_THRESHOLD = 30 * 60 * 1000; // 30 minutes in milliseconds
    const NOTIFICATION_WINDOW = 5 * 60 * 1000; // 5 minutes in milliseconds

    const currentTimestamp = this.getAdminTimestampWithZeroSeconds(); ;
    const startThresholdInSeconds = currentTimestamp.seconds + NOTIFICATION_THRESHOLD / 1000;
    const endThresholdInSeconds = currentTimestamp.seconds + (NOTIFICATION_THRESHOLD + NOTIFICATION_WINDOW) / 1000;

    const startThreshold = new admin.firestore.Timestamp(startThresholdInSeconds, 0);
    const endThreshold = new admin.firestore.Timestamp(endThresholdInSeconds, 0);

    console.log(`MatchRepository: Getting matches within threshold from ${startThreshold.toDate()} to ${endThreshold.toDate()}`);

    const upcomingMatchesQuery = this.matchRef()
      .where("start_at", ">=", startThreshold)
      .where("start_at", "<=", endThreshold);
    try {
      const upcomingMatchesSnapshot = await upcomingMatchesQuery.get();
      if (!upcomingMatchesSnapshot.empty) {
        console.log(`MatchRepository: ${upcomingMatchesSnapshot.docs.length} upcoming matches found within threshold`);
        const promises = upcomingMatchesSnapshot.docs.map(async (matchDoc) => {
          const matchData = matchDoc.data();
          await this.matchService.notifyBeforeMatchStart(matchData);
        });
        await Promise.all(promises);
      } else {
        console.log("MatchRepository: No upcoming matches found within threshold");
      }
    } catch (e) {
      console.error("MatchRepository: Error getting upcoming matches:", e);
    }
  }
}
exports.MatchRepository=MatchRepository;
