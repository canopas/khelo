"use strict";
Object.defineProperty(exports, "__esModule", {value: true});
exports.UserRepository = void 0;

class UserRepository {
  constructor(db) {
    this.db = db;
  }
  userRef() {
    return this.db.collection("users");
  }
  async getUser(userId) {
    const userRef = this.userRef().doc(userId);
    try {
      const userDoc = await userRef.get();
      if (!userDoc.exists) {
        return null;
      }
      return userDoc.data();
    } catch (e) {
      console.error("UserRepository: Error getting user:", e);
      return null;
    }
  }
  async getUsers(userIds) {
    const userRef = this.userRef().where("id", "in", userIds);
    try {
      const userDoc = await userRef.get();
      if (!userDoc.exists) {
        return [];
      }
      return userDoc.docs.map((doc) => doc.data());
    } catch (e) {
      console.error("UserRepository: Error getting users:", e);
      return [];
    }
  }
  async getSessions(userId) {
    const sessionsRef = this.userRef().doc(userId).collection("user_sessions");
    try {
      const sessionsDoc = await sessionsRef.get();
      return sessionsDoc.docs.map((doc) => doc.data());
    } catch (e) {
      console.error("UserRepository: Error getting user sessions:", e);
      return [];
    }
  }
}
exports.UserRepository = UserRepository;
