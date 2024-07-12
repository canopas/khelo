import 'package:data/api/team/team_model.dart';
import 'package:data/api/user/user_models.dart';

UserModel deActiveDummyUserAccount(String id) {
  return UserModel(
      id: id,
      name: 'Deactivated User',
      created_at: DateTime(1950),
      location: '--',
      isActive: false);
}

TeamModel deActiveDummyTeamModel(String id) {
  return TeamModel(
      id: id,
      name: 'Deactivated Team',
      name_lowercase: 'deactivatedteam',
      created_at: DateTime(1950),
      city: '--');
}
