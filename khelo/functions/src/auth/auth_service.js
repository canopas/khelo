"use strict";
Object.defineProperty(exports, "__esModule", {value: true});
exports.AuthService = void 0;
const firebase_admin = require("firebase-admin");
const {google} = require("googleapis");

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

  async updateGoogleRefreshToken(req, res) {
    try {
      const userId = req.headers["auth-uid"];
      if (!userId) {
        console.error("AuthService: unauthorized request");
        return res.status(400).send("unauthorized");
      }

      const authCode = req.body.authCode;
      const oauth2Client = new google.auth.OAuth2(
        process.env.WEB_CLIENT_ID,
        process.env.WEB_CLIENT_SECRET,
        process.env.REDIRECT_URL,
      );

      const {tokens} = await oauth2Client.getToken(authCode);
      oauth2Client.setCredentials(tokens);

      await this.userRepository.updateGoogleRefreshToken(userId, tokens.refresh_token);
      return res.status(200).send("Google refresh token stored successfully.");
    } catch (error) {
      return res.status(500).send(error);
    }
  }
}
exports.AuthService = AuthService;
