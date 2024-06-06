import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/user/user_models.dart';
import 'provider/preferences_provider.dart';

final currentUserJsonPod = createPrefProvider<String?>(
  prefKey: "user_account",
  defaultValue: null,
);

final currentUserPod = Provider<UserModel?>((ref) {
  final json = ref.watch(currentUserJsonPod);
  return json == null ? null : UserModel.fromJsonString(json);
});

final hasUserSession =
    Provider<bool>((ref) => ref.watch(currentUserPod) != null);
