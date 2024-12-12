import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:data/api/leaderboard/leaderboard_model.dart';
import 'package:data/api/match/match_model.dart';
import 'package:data/api/tournament/tournament_model.dart';
import 'package:data/api/user/user_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:style/extensions/context_extensions.dart';

extension BallTypeString on BallType {
  String getString(BuildContext context) {
    switch (this) {
      case BallType.leather:
        return context.l10n.add_match_ball_type_leather_title;
      case BallType.tennis:
        return context.l10n.add_match_ball_type_tennis_title;
      case BallType.other:
        return context.l10n.common_other_title;
    }
  }
}

extension MatchTypeString on MatchType {
  String getString(BuildContext context) {
    switch (this) {
      case MatchType.limitedOvers:
        return context.l10n.add_match_match_type_limited_overs_title;
      case MatchType.testMatch:
        return context.l10n.add_match_match_type_test_match_title;
      case MatchType.theHundred:
        return context.l10n.add_match_match_type_the_hundred_title;
      case MatchType.pairCricket:
        return context.l10n.add_match_match_type_pair_cricket_title;
      case MatchType.boxCricket:
        return context.l10n.add_match_match_type_box_cricket_title;
    }
  }
}

extension PitchTypeString on PitchType {
  String getString(BuildContext context) {
    switch (this) {
      case PitchType.rough:
        return context.l10n.add_match_pitch_type_rough_title;
      case PitchType.cement:
        return context.l10n.add_match_pitch_type_cement_title;
      case PitchType.turf:
        return context.l10n.add_match_pitch_type_turf_title;
      case PitchType.astroturf:
        return context.l10n.add_match_pitch_type_astroturf_title;
      case PitchType.matting:
        return context.l10n.add_match_pitch_type_matting_title;
    }
  }
}

extension PlayerRoleString on PlayerRole {
  String getString(BuildContext context) {
    switch (this) {
      case PlayerRole.topOrderBatter:
        return context.l10n.player_role_top_order_batter_title;
      case PlayerRole.middleOrderBatter:
        return context.l10n.player_role_middle_order_batter_title;
      case PlayerRole.wickerKeeperBatter:
        return context.l10n.player_role_wicket_keeper_batter_title;
      case PlayerRole.wicketKeeper:
        return context.l10n.player_role_wicket_keeper_title;
      case PlayerRole.bowler:
        return context.l10n.player_role_bowler_title;
      case PlayerRole.allRounder:
        return context.l10n.player_role_all_rounder_title;
      case PlayerRole.lowerOrderBatter:
        return context.l10n.player_role_lower_order_batter_title;
      case PlayerRole.openingBatter:
        return context.l10n.player_role_opening_batter_title;
      case PlayerRole.none:
        return context.l10n.common_none_title;
    }
  }
}

extension BowlingStyleString on BowlingStyle {
  String getString(BuildContext context) {
    switch (this) {
      case BowlingStyle.rightArmFast:
        return context.l10n.bowling_style_right_arm_fast_title;
      case BowlingStyle.rightArmMedium:
        return context.l10n.bowling_style_right_arm_medium_title;
      case BowlingStyle.leftArmFast:
        return context.l10n.bowling_style_left_arm_fast_title;
      case BowlingStyle.leftArmMedium:
        return context.l10n.bowling_style_left_arm_medium_title;
      case BowlingStyle.slowLeftArmOrthodox:
        return context.l10n.bowling_style_slow_left_arm_orthodox_title;
      case BowlingStyle.slowLeftArmChinaMan:
        return context.l10n.bowling_style_slow_left_arm_chinaman_title;
      case BowlingStyle.rightArmOffBreak:
        return context.l10n.bowling_style_right_arm_off_break_title;
      case BowlingStyle.rightArmLegBreak:
        return context.l10n.bowling_style_right_arm_leg_break_title;
      case BowlingStyle.none:
        return context.l10n.common_none_title;
    }
  }
}

extension FieldingPositionString on FieldingPositionType {
  String getString(BuildContext context) {
    switch (this) {
      case FieldingPositionType.deepMidWicket:
        return context.l10n.fielding_position_deep_mid_wicket_title;
      case FieldingPositionType.longOn:
        return context.l10n.fielding_position_long_on_title;
      case FieldingPositionType.longOff:
        return context.l10n.fielding_position_long_off_title;
      case FieldingPositionType.deepCover:
        return context.l10n.fielding_position_deep_cover_title;
      case FieldingPositionType.deepPoint:
        return context.l10n.fielding_position_deep_point_title;
      case FieldingPositionType.thirdMan:
        return context.l10n.fielding_position_third_man_title;
      case FieldingPositionType.deepFineLeg:
        return context.l10n.fielding_position_deep_fine_leg_title;
      case FieldingPositionType.deepSquareLeg:
        return context.l10n.fielding_position_deep_square_leg_title;
    }
  }
}

extension SideString on Side {
  String getString(BuildContext context) {
    switch (this) {
      case Side.off:
        return context.l10n.side_off_title;
      case Side.leg:
        return context.l10n.side_leg_title;
    }
  }
}

extension BattingStyleString on BattingStyle {
  String getString(BuildContext context) {
    switch (this) {
      case BattingStyle.rightHandBat:
        return context.l10n.batting_style_right_hand_bat_title;
      case BattingStyle.leftHandBat:
        return context.l10n.batting_style_left_hand_bat_title;
    }
  }
}

extension UserGenderString on UserGender {
  String getString(BuildContext context) {
    switch (this) {
      case UserGender.male:
        return context.l10n.edit_profile_gender_male_title;
      case UserGender.female:
        return context.l10n.edit_profile_gender_female_title;
      case UserGender.other:
        return context.l10n.edit_profile_gender_prefer_not_to_say_title;
      case UserGender.unknown:
        return "";
    }
  }
}

extension TossDecisionString on TossDecision {
  String getString(BuildContext context) {
    switch (this) {
      case TossDecision.bat:
        return context.l10n.common_batting;
      case TossDecision.bowl:
        return context.l10n.common_bowling;
    }
  }
}

extension MatchStatusString on MatchStatus {
  String getString(BuildContext context) {
    switch (this) {
      case MatchStatus.yetToStart:
        return context.l10n.match_status_yet_to_start_title;
      case MatchStatus.running:
        return context.l10n.commonRunning;
      case MatchStatus.finish:
        return context.l10n.commonFinish;
      case MatchStatus.abandoned:
        return context.l10n.match_status_abandoned_title;
    }
  }

  Color getColor(BuildContext context) {
    switch (this) {
      case MatchStatus.yetToStart:
        return context.colorScheme.warning;
      case MatchStatus.running:
        return context.colorScheme.alert;
      case MatchStatus.finish:
        return context.colorScheme.positive;
      case MatchStatus.abandoned:
        return context.colorScheme.secondary;
    }
  }
}

extension TournamentStatusString on TournamentStatus {
  String getString(BuildContext context) {
    switch (this) {
      case TournamentStatus.upcoming:
        return context.l10n.home_screen_upcoming_title;
      case TournamentStatus.running:
        return context.l10n.commonRunning;
      case TournamentStatus.finish:
        return context.l10n.commonFinish;
    }
  }

  Color getColor(BuildContext context) {
    switch (this) {
      case TournamentStatus.upcoming:
        return context.colorScheme.warning;
      case TournamentStatus.running:
        return context.colorScheme.alert;
      case TournamentStatus.finish:
        return context.colorScheme.positive;
    }
  }
}

extension WicketTypeString on WicketType {
  String getString(BuildContext context) {
    switch (this) {
      case WicketType.bowled:
        return context.l10n.wicket_type_bowled_title;
      case WicketType.caught:
        return context.l10n.wicket_type_caught_title;
      case WicketType.caughtBehind:
        return context.l10n.wicket_type_caught_behind_title;
      case WicketType.caughtAndBowled:
        return context.l10n.wicket_type_caught_bowled_title;
      case WicketType.lbw:
        return context.l10n.wicket_type_leg_before_wicket_title;
      case WicketType.stumped:
        return context.l10n.wicket_type_stumped_title;
      case WicketType.runOut:
        return context.l10n.common_run_out_title;
      case WicketType.hitWicket:
        return context.l10n.wicket_type_hit_wicket_title;
      case WicketType.hitBallTwice:
        return context.l10n.wicket_type_hit_ball_twice_title;
      case WicketType.handledBall:
        return context.l10n.wicket_type_handled_ball_title;
      case WicketType.obstructingField:
        return context.l10n.wicket_type_obstructing_field_title;
      case WicketType.timedOut:
        return context.l10n.wicket_type_timed_out_title;
      case WicketType.retired:
        return context.l10n.wicket_type_retired_title;
      case WicketType.retiredHurt:
        return context.l10n.wicket_type_retired_hurt_title;
    }
  }
}

extension ExtrasTypeString on ExtrasType {
  String getString(BuildContext context) {
    switch (this) {
      case ExtrasType.wide:
        return context.l10n.score_board_wide_ball_short_text;
      case ExtrasType.noBall:
        return context.l10n.score_board_no_ball_short_text;
      case ExtrasType.penaltyRun:
        return context.l10n.score_board_penalty_run_title;
      case ExtrasType.bye:
        return context.l10n.score_board_bye_short_text;
      case ExtrasType.legBye:
        return context.l10n.score_board_leg_bye_short_text;
    }
  }
}

extension WinnerByTypeString on WinnerByType {
  String getString(BuildContext context, int difference) {
    switch (this) {
      case WinnerByType.run:
        return context.l10n.common_runs_title(difference);
      case WinnerByType.wicket:
        return context.l10n.common_wickets_title(difference);
      case WinnerByType.tie:
        return context.l10n.common_tie_title;
    }
  }
}

extension TournamentTypeString on TournamentType {
  String getString(BuildContext context) {
    switch (this) {
      case TournamentType.knockOut:
        return context.l10n.tournament_type_knock_out;
      case TournamentType.miniRobin:
        return context.l10n.tournament_type_mini_robin;
      case TournamentType.boxLeague:
        return context.l10n.tournament_type_box_league;
      case TournamentType.doubleOut:
        return context.l10n.tournament_type_double_out;
      case TournamentType.bestOfThree:
        return context.l10n.tournament_type_best_of_three;
      case TournamentType.custom:
        return context.l10n.tournament_type_custom;
    }
  }

  String getDescriptionString(BuildContext context) {
    switch (this) {
      case TournamentType.knockOut:
        return context.l10n.tournament_type_knock_out_description(minTeamReq);
      case TournamentType.miniRobin:
        return context.l10n.tournament_type_mini_robin_description(minTeamReq);
      case TournamentType.boxLeague:
        return context.l10n.tournament_type_box_league_description(minTeamReq);
      case TournamentType.doubleOut:
        return context.l10n.tournament_type_double_out_description(minTeamReq);
      case TournamentType.bestOfThree:
        return context.l10n
            .tournament_type_best_of_three_description(minTeamReq);
      case TournamentType.custom:
        return context.l10n.tournament_type_custom_description(minTeamReq);
    }
  }
}

extension MatchGroupString on MatchGroup {
  String getString(BuildContext context) {
    switch (this) {
      case MatchGroup.round:
        return context.l10n.match_group_round_title;
      case MatchGroup.quarterfinal:
        return context.l10n.match_group_quarter_final_title;
      case MatchGroup.semifinal:
        return context.l10n.match_group_semi_final_title;
      case MatchGroup.finals:
        return context.l10n.match_group_final_title;
    }
  }
}

extension TournamentKeyStatString on KeyStatTag {
  String getString(BuildContext context) {
    switch (this) {
      case KeyStatTag.mostRuns:
        return context.l10n.tournament_detail_key_stat_most_runs_title;
      case KeyStatTag.mostWickets:
        return context.l10n.tournament_detail_key_stat_most_wickets_title;
      case KeyStatTag.mostFours:
        return context.l10n.tournament_detail_key_stat_most_fours_title;
      case KeyStatTag.mostSixes:
        return context.l10n.tournament_detail_key_stat_most_sixes_title;
    }
  }
}

extension LeaderboardFieldTypeString on LeaderboardField {
  String getString(BuildContext context) {
    switch (this) {
      case LeaderboardField.batting:
        return context.l10n.common_batting;
      case LeaderboardField.bowling:
        return context.l10n.common_bowling;
      case LeaderboardField.fielding:
        return context.l10n.common_fielding;
    }
  }
}
