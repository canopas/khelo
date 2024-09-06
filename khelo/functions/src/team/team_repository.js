"use strict";
Object.defineProperty(exports, "__esModule", {value: true});
exports.TeamRepository = void 0;

class TeamRepository {
  constructor(db) {
    this.db = db;
  }
  teamRef() {
    return this.db.collection("teams");
  }
  async getTeams(teamIds) {
    const teamRef = this.teamRef.where("id", "in", teamIds);
    try {
      const teamDoc = await teamRef.get();
      if (!teamDoc.exists) {
        return [];
      }
      return teamDoc.docs.map((doc) => doc.data());
    } catch (e) {
      console.error("TeamRepository: Error getting Teams:", e);
      return [];
    }
  }
}
exports.TeamRepository=TeamRepository;
