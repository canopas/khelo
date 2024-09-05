"use strict";
Object.defineProperty(exports, "__esModule", {value: true});
exports.MatchService = void 0;
const user_models = require("../user/user_models");
class MatchService {
  constructor(userRepository, teamRepository, notificationService) {
    this.userRepository = userRepository;
    this.teamRepository = teamRepository;
    this.notificationService = notificationService;
  }
  async notifyBeforeMatchStart(match) {
    const [teamA, teamB] = await this.teamRepository.getTeams(match.team_ids);
    const matchContributorIds = new Set([
      match.created_by,
      match.referee_id,
      ...match.players,
      ...match.scorer_ids,
      ...match.umpire_ids,
      ...match.commentator_ids,
    ]);

    const matchContributors = await this.userRepository.getUsers(matchContributorIds);
    const usersToNotify = matchContributors.filter((m) => user_models.userNotificationEnabled(m)).map((m)=> m.id);

    console.log("users to notify:", usersToNotify);

    if (usersToNotify.length > 0) {
      const title = "Match Alert!";
      const body = `${teamA.name} vs. ${teamB.name} is starting in 30 minutes!`;
      await this.notificationService.sendNotification(usersToNotify, title, body, {matchId: match.id, type: "match_start"});
    }
  }
}
exports.MatchService = MatchService;
