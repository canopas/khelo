class FireStoreConst {
  // collection
  static const String matchesCollection = "matches";
  static const String matchSettingsSubCollection = "match_settings";
  static const String settingDocument = "setting";
  static const String teamsCollection = "teams";
  static const String teamStatCollection = "team_stat";
  static const String inningsCollection = "innings";
  static const String ballScoresCollection = "ball_scores";
  static const String usersCollection = "users";
  static const String userSessionCollection = "user_sessions";
  static const String userStatCollection = "user_stat";
  static const String supportCollection = "contact_support";
  static const String tournamentCollection = "tournaments";
  static const String tournamentTeamStatsCollection = "team_stats";
  static const String tournamentPlayerKeyStatsCollection = "player_key_stats";


  // matches field const
  static const String id = "id";
  static const String teams = "teams";
  static const String teamId = "team_id";
  static const String run = "run";
  static const String over = "over";
  static const String wicket = "wicket";
  static const String squad = "squad";
  static const String currentPlayingTeamId = "current_playing_team_id";
  static const String matchStatus = "match_status";
  static const String tossWinnerId = "toss_winner_id";
  static const String tossDecision = "toss_decision";
  static const String teamIds = "team_ids";
  static const String teamCreatorIds = "team_creator_ids";
  static const String revisedTarget = "revised_target";
  static const String updatedAt = "updated_at";
  static const String startAt = "start_at";
  static const String type = "type";

  // innings field const
  static const String matchId = "match_id";
  static const String inningsStatus = "innings_status";
  static const String overs = "overs";
  static const String totalRuns = "total_runs";
  static const String totalWickets = "total_wickets";

  // ball score field const
  static const String inningId = "inning_id";
  static const String bowlerId = "bowler_id";
  static const String batsmanId = "batsman_id";
  static const String wicketTakerId = "wicket_taker_id";
  static const String playerOutId = "player_out_id";

  // teams field const
  static const String players = "players";
  static const String teamPlayers = "team_players";
  static const String createdBy = "created_by";
  static const String nameLowercase = "name_lowercase";
  static const String profileImageUrl = "profile_img_url";
  static const String stat = "stat";

  // users field const
  static const String deviceFcmToken = "device_fcm_token";
  static const String notifications = "notifications";
  static const String phone = "phone";
  static const String name = "name";

  // tournament field const
  static const String members = "members";
  static const String matchIds = "match_ids";
  static const String endDate = "end_date";
  static const String startDate = "start_date";
}

class DataConfig {
  static late DataConfig _instance;

  static DataConfig get instance => _instance;

  static void init(DataConfig dataConfig) {
    _instance = dataConfig;
  }

  final String apiBaseUrl;

  DataConfig({
    required this.apiBaseUrl,
  });
}
