"use strict";
Object.defineProperty(exports, "__esModule", {value: true});
exports.LeaderboardService = void 0;
const firestore_1 = require("firebase-admin/firestore");

class LeaderboardService {
  constructor(leaderboardRepository) {
    this.leaderboardRepository = leaderboardRepository;
  }

  async updateLeaderboard(userId, oldStat, newStat) {
    let weekStat = await this.leaderboardRepository.getWeeklyLeaderboardOfUser(userId);
    let monthStat = await this.leaderboardRepository.getMonthlyLeaderboardOfUser(userId);
    let allTimeStat = await this.leaderboardRepository.getAllTimeLeaderboardOfUser(userId);

    const runDiff = (newStat.batting?.run_scored ?? 0) - (oldStat?.batting?.run_scored ?? 0);
    const wicketDiff = (newStat.bowling?.wicket_taken ?? 0) - (oldStat?.bowling?.wicket_taken ?? 0);
    const catchDiff = (newStat.fielding?.catches ?? 0) - (oldStat?.fielding?.catches ?? 0);

    const runs = runDiff >= 0 ? runDiff : newStat.batting?.run_scored ?? 0;
    const wickets = wicketDiff >= 0 ? wicketDiff : newStat.bowling?.wicket_taken ?? 0;
    const catches = catchDiff >= 0 ? catchDiff : newStat.fielding?.catches ?? 0;

    if (!weekStat) {
      weekStat = {id: userId, runs: runs, wickets: wickets, catches: catches, date: new Date()};
    } else {
      if (weekStat.date instanceof firestore_1.Timestamp && this.isTimeInCurrentWeek(weekStat.date.toDate())) {
        weekStat.runs += runs;
        weekStat.wickets += wickets;
        weekStat.catches += catches;
      } else {
        weekStat.runs = runs;
        weekStat.wickets = wickets;
        weekStat.catches = catches;
      }
      weekStat.date = new Date();
    }

    // Check if monthStat exists, otherwise create a new object
    if (!monthStat) {
      monthStat = {id: userId, runs: runs, wickets: wickets, catches: catches, date: new Date()};
    } else {
    // Update the monthStat if it's within the current month, else reset it
      if (monthStat.date instanceof firestore_1.Timestamp && this.isTimeInCurrentMonth(monthStat.date.toDate())) {
        monthStat.runs += runs;
        monthStat.wickets += wickets;
        monthStat.catches += catches;
      } else {
        monthStat.runs = runs;
        monthStat.wickets = wickets;
        monthStat.catches = catches;
      }
      monthStat.date = new Date();
    }

    if (!allTimeStat) {
      allTimeStat = {id: userId, runs: runs, wickets: wickets, catches: catches, date: new Date()};
    } else {
      allTimeStat.runs += runs;
      allTimeStat.wickets += wickets;
      allTimeStat.catches += catches;
      allTimeStat.date = new Date();
    }

    await this.leaderboardRepository.updateWeeklyLeaderboardOfUser(weekStat);
    await this.leaderboardRepository.updateMonthlyLeaderboardOfUser(monthStat);
    await this.leaderboardRepository.updateAllTimeLeaderboardOfUser(allTimeStat);
  }

  isTimeInCurrentWeek(date) {
    // Note: Current week starts from Monday and ends on Sunday
    const givenDate = new Date(date);
    const currentDate = new Date();

    const startOfWeek = new Date(currentDate);
    startOfWeek.setDate(currentDate.getDate() - currentDate.getDay() + 1);

    const endOfWeek = new Date(startOfWeek);
    endOfWeek.setDate(startOfWeek.getDate() + 6);

    return givenDate >= startOfWeek && givenDate <= endOfWeek;
  }

  isTimeInCurrentMonth(date) {
    const givenDate = new Date(date);
    const currentDate = new Date();

    return (
      givenDate.getMonth() === currentDate.getMonth() &&
        givenDate.getFullYear() === currentDate.getFullYear()
    );
  }
}
exports.LeaderboardService = LeaderboardService;
