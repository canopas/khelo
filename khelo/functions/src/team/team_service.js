"use strict";
Object.defineProperty(exports, "__esModule", {value: true});
exports.TeamService = void 0;
const user_models = require("../user/user_models");

class TeamService {
  constructor(userRepository, notificationService) {
    this.userRepository = userRepository;
    this.notificationService = notificationService;
  }
  async notifyOnAddedToTeam(oldTeam, newTeam) {
    const oldPlayers = oldTeam.team_players || [];
    const newPlayers = newTeam.team_players || [];

    const addedPlayerIds = newPlayers.filter((player) => !oldPlayers.some((oldPlayer) => oldPlayer.id === player.id));
    const addedPlayers = await this.userRepository.getUsers(addedPlayerIds);
    const playersToNotify = addedPlayers.filter((m) => user_models.userNotificationEnabled(m)).map((m)=> m.id);

    console.log("Players to notify:", playersToNotify);

    if (playersToNotify.length > 0) {
      const title = "Welcome to ${newTeam.name}";
      const body = "You've been added to ${newTeam.name}. Get ready to join the action and play with your new teammates!";
      await this.notificationService.sendNotification(playersToNotify, title, body, {teamId: newTeam.id, type: "added_to_team"});
    }
  }
}
exports.TeamService = TeamService;
