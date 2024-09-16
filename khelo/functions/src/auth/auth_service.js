"use strict";
Object.defineProperty(exports, "__esModule", {value: true});
exports.AuthService = void 0;
const firebase_admin = require("firebase-admin");
class AuthService {
  constructor(userRepository) {
    this.userRepository = userRepository;
  }
  async onCallCreateAuthUser(req, res) {
    const userId = req.headers["auth-uid"];
    if (!userId) {
      console.error("AuthService: unauthorized request");
      return res.status(400).send("unauthorized");
    }
    const request = req.body;
    if (!request.phone || !request.name) {
      console.error("AuthService: missing parameters");
      return res.status(400).send("missing-params");
    }
    const userRecord = await firebase_admin.auth().createUser({
      phoneNumber: request.phone,
      displayName: request.name,
    });
    const user = await this.userRepository.createUser(userRecord.uid, request.name, request.phone);
    console.log("AuthService: User has been created", user);
    if (user != null) {
      res.status(200).send(user);
    } else {
      res.status(400).send("internal-error");
    }
  }
}
exports.AuthService = AuthService;
