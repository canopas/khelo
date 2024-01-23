import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/user/user_models.dart';
import '../../storage/app_preferences.dart';

final userServiceProvider = Provider((ref) {
  final service = UserService();
  ref.listen(currentUserPod, (_, next) => service.currentUser = next);
  return service;
});

class UserService {
  User? currentUser;
/*
// caller function here
 func callerFunctionCalledFromNotifier(){
  var response = await funcThatInternallyDoTheseStuff();
  parse the response
  return the response
 }
*/
}