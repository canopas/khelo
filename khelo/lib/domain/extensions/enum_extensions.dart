import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:data/api/match/match_model.dart';
import 'package:data/api/user/user_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';

extension BallTypeString on BallType {
  String getString(BuildContext context) {
    switch (this) {
      case BallType.leather:
        return context.l10n.add_match_ball_type_leather_title;
      case BallType.tennis:
        return context.l10n.add_match_ball_type_tennis_title;
      case BallType.other:
        return context.l10n.add_match_ball_type_other_title;
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
        return context.l10n.edit_profile_gender_other_title;
      case UserGender.unknown:
        return "";
    }
  }
}

extension TossDecisionString on TossDecision {
  String getString(BuildContext context) {
    switch (this) {
      case TossDecision.bat:
        return context.l10n.add_toss_detail_bat_text;
      case TossDecision.bowl:
        return context.l10n.add_toss_detail_bowl_text;
    }
  }
}

extension WicketTypeString on WicketType{
  String getString(BuildContext context) {
    switch (this) {
      case WicketType.bowled:
        return "Bowled";
      case WicketType.caught:
        return "Caught";
      case WicketType.caughtBehind:
        return "Caught Behind";
      case WicketType.caughtAndBowled:
        return "Caught And Bowled";
      case WicketType.lbw:
        return "Leg Before Wicket";
      case WicketType.stumped:
        return "Stumped";
      case WicketType.runOut:
        return "Run Out";
      case WicketType.hitWicket:
        return "Hit Wicket";
      case WicketType.hitBallTwice:
        return "Hit Ball Twice";
      case WicketType.handledBall:
        return "Handled Ball";
      case WicketType.obstructingField:
        return "Obstructing the Field";
      case WicketType.timedOut:
        return "Timed Out";
      case WicketType.retired:
        return "Retired";
      case WicketType.retiredHurt:
        return "Retired Hurt";
    }
  }
}
