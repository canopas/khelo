"use strict";
Object.defineProperty(exports, "__esModule", {value: true});
exports.userNotificationEnabled = void 0;
const userNotificationEnabled = (user) => {
  return user.notifications === null ? true : user.notifications;
};
exports.userNotificationEnabled = userNotificationEnabled;
