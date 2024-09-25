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
    const addedPlayerIds = newPlayers.filter((player) => !oldPlayers.some((oldPlayer) => oldPlayer.id === player.id)).map((m) => m.id);
    console.log("TeamService: Newly added players:", addedPlayerIds);
    if (addedPlayerIds.length === 0) {
      return;
    }
    const addedPlayers = await this.userRepository.getUsers(addedPlayerIds);
    const playersToNotify = addedPlayers.filter((m) => user_models.userNotificationEnabled(m)).map((m)=> m.id);

    console.log("TeamService: Players to notify:", playersToNotify);
    const teamName=newTeam.name;
    const teamId= newTeam.id;
    if (playersToNotify.length > 0 && typeof teamId === "string" && typeof teamName === "string") {
      const title =`Welcome to ${teamName}`;
      const body = `You have been added to ${teamName}. Get ready to join the action and play with your new teammates!`;
      await this.notificationService.sendNotification(playersToNotify, title, body, {team_id: teamId, type: "added_to_team"});
    }
  }
}
exports.TeamService = TeamService;
