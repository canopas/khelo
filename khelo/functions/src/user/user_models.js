"use strict";
Object.defineProperty(exports, "__esModule", {value: true});
exports.userNotificationEnabled = void 0;
const userNotificationEnabled = (user) => {
  return user.notifications === null || user.notifications === undefined ? true : user.notifications;
};
exports.userNotificationEnabled = userNotificationEnabled;
