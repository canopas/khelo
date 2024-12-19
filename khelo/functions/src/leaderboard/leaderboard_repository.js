"use strict";
Object.defineProperty(exports, "__esModule", {value: true});
exports.LeaderboardRepository = void 0;

class LeaderboardRepository {
  constructor(db) {
    this.db = db;
  }
  leaderboardRef() {
    return this.db.collection("leaderboard");
  }
  timeBasedLeaderboardRef(timeRange) {
    return this.leaderboardRef()
      .doc(timeRange)
      .collection("data");
  }

  async getWeeklyLeaderboardOfUser(userId) {
    try {
      const userRef = this.timeBasedLeaderboardRef("weekly").doc(userId);
      const weeklyDoc = await userRef.get();
      if (!weeklyDoc.exists) {
        return null;
      }
      return weeklyDoc.data();
    } catch (e) {
      console.error("LeaderboardRepository: Error getting weekly data of user:", e);
      return null;
    }
  }

  async getMonthlyLeaderboardOfUser(userId) {
    try {
      const userRef = this.timeBasedLeaderboardRef("monthly").doc(userId);
      const monthlyDoc = await userRef.get();
      if (!monthlyDoc.exists) {
        return null;
      }
      return monthlyDoc.data();
    } catch (e) {
      console.error("LeaderboardRepository: Error getting monthly data of user:", e);
      return null;
    }
  }

  async getAllTimeLeaderboardOfUser(userId) {
    try {
      const userRef = this.timeBasedLeaderboardRef("all_time").doc(userId);
      const allTimeDoc = await userRef.get();
      if (!allTimeDoc.exists) {
        return null;
      }
      return allTimeDoc.data();
    } catch (e) {
      console.error("LeaderboardRepository: Error getting all time data of user:", e);
      return null;
    }
  }

  async updateWeeklyLeaderboardOfUser(stats) {
    try {
      const userRef = this.timeBasedLeaderboardRef("weekly").doc(stats.id);
      await userRef.set(stats);
    } catch (e) {
      console.error("LeaderboardRepository: Error in updating weekly data of user:", e);
      return null;
    }
  }

  async updateMonthlyLeaderboardOfUser(stats) {
    try {
      const userRef = this.timeBasedLeaderboardRef("monthly").doc(stats.id);
      await userRef.set(stats);
    } catch (e) {
      console.error("LeaderboardRepository: Error in updating monthly data of user:", e);
      return null;
    }
  }

  async updateAllTimeLeaderboardOfUser(stats) {
    try {
      const userRef = this.timeBasedLeaderboardRef("all_time").doc(stats.id);
      await userRef.set(stats);
    } catch (e) {
      console.error("LeaderboardRepository: Error in updating all time data of user:", e);
      return null;
    }
  }
}
exports.LeaderboardRepository=LeaderboardRepository;
