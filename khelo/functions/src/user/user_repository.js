"use strict";
Object.defineProperty(exports, "__esModule", {value: true});
exports.firebaseAuthMiddleware = exports.UserRepository = void 0;
const firestore_1 = require("firebase-admin/firestore");
const admin = require("firebase-admin");
class UserRepository {
  constructor(db) {
    this.db = db;
  }
  userRef() {
    return this.db.collection("users");
  }
  async createUser(userId, userName, phoneNumber) {
    const userRef = this.userRef().doc(userId);
    try {
      const user = {
        id: userId,
        name: userName,
        name_lowercase: userName.toLowerCase(),
        phone: phoneNumber,
        created_at: new Date().toISOString(),
        create_time: firestore_1.Timestamp.now(),
      };
      await userRef.set(user);

      return user;
    } catch (e) {
      console.error("UserRepository: Error creating user:", e);
      return null;
    }
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
const firebaseAuthMiddleware = (userRepository) => {
  return async (req, res, next) => {
    let _a;
    const idToken = (_a = req.get("Authorization")) === null || _a === void 0 ? void 0 : _a.split("Bearer ")[1];
    if (!idToken) {
      res.status(403).send("Unauthorized");
      return;
    }

    const auth = await admin.auth().verifyIdToken(idToken);
    if (!auth) {
      res.status(403).send("Unauthorized");
      return;
    }
    const user = await userRepository.getUser(auth.uid);
    if (!user) {
      res.status(403).send("Unauthorized");
      return;
    }
    console.log("Authenticated user: ", auth.uid);
    req.headers["auth-uid"] = auth.uid;
    next();
  };
};
exports.firebaseAuthMiddleware = firebaseAuthMiddleware;
exports.UserRepository = UserRepository;
