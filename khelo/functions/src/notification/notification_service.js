"use strict";
Object.defineProperty(exports, "__esModule", {value: true});
exports.NotificationService = void 0;
const firebase_admin = require("firebase-admin");

class NotificationService {
  constructor(userRepository) {
    this.userRepository = userRepository;
  }
  async sendNotification(userIds, title, body, data) {
    console.log("NotificationService: Sending notification to: ", userIds, title, body, data);
    const tokens = new Set();
    for (const userId of userIds) {
      const userSessions = await this.userRepository.getSessions(userId);
      for (const session of userSessions) {
        if (session.device_fcm_token) {
          tokens.add(session.device_fcm_token);
        }
      }
    }
    if (tokens.size == 0) {
      console.debug("NotificationService: No tokens found for user");
      return;
    }
    const payload = {
      tokens: [...tokens],
      notification: {
        title: title,
        body: body,
      },
      data: data,
      android: {
        priority: "high",
        notification: {
          sound: "default",
        },
      },
      apns: {
        payload: {
          aps: {
            sound: "default",
          },
        },
      },
    };

    const response = await (0, firebase_admin.messaging)().sendEachForMulticast(payload);
    console.log("NotificationService: Sent notification response:", JSON.stringify(response, null, 2));
  }
}
exports.NotificationService = NotificationService;
