import '../api/team/team_model.dart';
import '../api/user/user_models.dart';

UserModel deActiveDummyUserAccount(String id) {
  return UserModel(
    id: id,
    name: 'Deactivated User',
    created_at2: DateTime(1950),
    location: '--',
    isActive: false,
  );
}

TeamModel deActiveDummyTeamModel(String id) {
  return TeamModel(
    id: id,
    name: 'Deactivated Team',
    name_lowercase: 'deactivatedteam',
    created_at2: DateTime(1950),
    city: '--',
  );
}
