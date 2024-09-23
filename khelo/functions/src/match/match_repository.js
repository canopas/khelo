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
  async processUpcomingMatches() {
    const NOTIFICATION_THRESHOLD = 30 * 60 * 1000; // 30 minutes in milliseconds
    const NOTIFICATION_WINDOW = 5 * 60 * 1000; // 5 minutes in milliseconds

    const currentTimestamp = admin.firestore.Timestamp.now();
    const startThresholdInSeconds = currentTimestamp.seconds + NOTIFICATION_THRESHOLD / 1000;
    const endThresholdInSeconds = currentTimestamp.seconds + (NOTIFICATION_THRESHOLD + NOTIFICATION_WINDOW) / 1000;

    const startThreshold = new admin.firestore.Timestamp(startThresholdInSeconds, 0);
    const endThreshold = new admin.firestore.Timestamp(endThresholdInSeconds, 0);

    const upcomingMatchesQuery = this.matchRef()
      .where("start_at", ">=", startThreshold)
      .where("start_at", "<=", endThreshold);
    try {
      const upcomingMatchesSnapshot = await upcomingMatchesQuery.get();
      if (!upcomingMatchesSnapshot.empty) {
        const promises = upcomingMatchesSnapshot.docs.map(async (matchDoc) => {
          const matchData = matchDoc.data();
          await this.matchService.notifyBeforeMatchStart(matchData);
        });
        await Promise.all(promises);
      } else {
        console.log(`MatchRepository: No upcoming matches found within threshold.from ${startThreshold.toDate().toLocaleString()} to ${endThreshold.toDate().toLocaleString()}`);
      }
    } catch (e) {
      console.error("MatchRepository: Error getting upcoming matches:", e);
    }
  }
}
exports.MatchRepository=MatchRepository;
