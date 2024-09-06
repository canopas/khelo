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
    const currentTimestamp = admin.firestore.Timestamp.now();
    const NOTIFICATION_THRESHOLD = 30 * 60 * 1000; // 30 minutes in milliseconds

    const upcomingMatchesQuery = this.matchRef()
      .where("start_time", ">=", currentTimestamp)
      .where("start_time", "<=", new admin.firestore.Timestamp(currentTimestamp.seconds + NOTIFICATION_THRESHOLD / 1000, 0));
    try {
      const upcomingMatchesSnapshot = await upcomingMatchesQuery.get();
      if (!upcomingMatchesSnapshot.empty) {
        const promises = upcomingMatchesSnapshot.docs.map(async (matchDoc) => {
          const matchData = matchDoc.data();
          await this.matchService.notifyBeforeMatchStart(matchData);
        });
        await Promise.all(promises);
      } else {
        console.log("No upcoming matches found within the notification threshold.");
      }
    } catch (e) {
      console.error("MatchRepository: Error getting upcoming matches:", e);
    }
  }
}
exports.MatchRepository=MatchRepository;
