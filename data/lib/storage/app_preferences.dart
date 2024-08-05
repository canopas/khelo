import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../api/user/user_models.dart';
import 'provider/preferences_provider.dart';

final currentUserSessionJsonPod = createPrefProvider<String?>(
  prefKey: "user_session",
  defaultValue: null,
);

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

final deviceIdPod = createPrefProvider<String>(
  prefKey: "unique_device_id",
  defaultValue: const Uuid().v4(),
);

final lastNotificationPermissionPromptDatePod = createPrefProvider<String?>(
  prefKey: 'last_notification_permission_prompt_shown_date',
  defaultValue: null,
);
