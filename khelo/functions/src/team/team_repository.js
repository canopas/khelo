"use strict";
Object.defineProperty(exports, "__esModule", {value: true});
exports.TeamRepository = void 0;
const firestore_1 = require("firebase-admin/firestore");

class TeamRepository {
  constructor(db) {
    this.db = db;
  }
  teamRef() {
    return this.db.collection("teams");
  }
  async getTeams(teamIds) {
    const teamRef = this.teamRef().where("id", "in", teamIds);
    try {
      const teamDoc = await teamRef.get();
      return teamDoc.docs.map((doc) => doc.data());
    } catch (e) {
      console.error("TeamRepository: Error getting teams:", e);
      return [];
    }
  }

  async getTeamsCreatedByUserId(userId) {
    const teamRef = this.teamRef().where("created_by", "==", userId);
    try {
      const teamDoc = await teamRef.get();
      return teamDoc.docs.map((doc) => doc.data());
    } catch (e) {
      console.error("TeamRepository: Error getting teams created by user id:", e);
      return [];
    }
  }

  async changePlayerRoleToAdmin(teamId, playerId) {
    const teamRef = this.teamRef().doc(teamId);
    const batch = this.db.batch();
    try {
      const elementToRemove= {"id": playerId, "role": "player"};
      const elementToAdd = {"id": playerId, "role": "admin"};
      batch.update(teamRef, {
        team_players: firestore_1.FieldValue.arrayRemove(elementToRemove),
      });
      batch.update(teamRef, {
        team_players: firestore_1.FieldValue.arrayUnion(elementToAdd),
      });
      await batch.commit();
    } catch (e) {
      console.error("TeamRepository: Error while changing player role to admin:", e);
    }
  }

  async markNoAdminTrueInTeam(teamId) {
    const teamRef = this.teamRef().doc(teamId);
    try {
      await teamRef.update({no_admin: true});
    } catch (e) {
      console.error("TeamRepository: Error while marking no admin as true in team:", e);
    }
  }
}
exports.TeamRepository=TeamRepository;
