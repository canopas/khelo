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
    console.log("Contributors in match:", addedPlayerIds);
    if(matchContributorIds.length === 0) {
        return;
    }
    const matchContributors = await this.userRepository.getUsers(matchContributorIds);
    const usersToNotify = matchContributors.filter((m) => user_models.userNotificationEnabled(m)).map((m)=> m.id);

    console.log("Users to notify:", usersToNotify);

const teamAName = teamA.name;
const teamBName = teamB.name;
const matchId = match.id;
    if (usersToNotify.length > 0 && typeof matchId === 'string' && typeof teamAName === 'string'  && typeof teamBName === 'string') {
      const title = "Match Alert!";
      const body = `${teamAName} vs. ${teamBName} is starting in 30 minutes!`;
      await this.notificationService.sendNotification(usersToNotify, title, body, {matchId: matchId, type: "match_start"});
    }
  }
}
exports.MatchService = MatchService;
