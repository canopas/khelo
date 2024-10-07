import 'dart:async';

import 'package:data/api/user/user_models.dart';
import 'package:data/service/user/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_user_view_model.freezed.dart';

final searchUserStateProvider = StateNotifierProvider.autoDispose<
    SearchUserViewNotifier, SearchUserViewState>((ref) {
  return SearchUserViewNotifier(
    ref.read(userServiceProvider),
  );
});

class SearchUserViewNotifier extends StateNotifier<SearchUserViewState> {
  final UserService _userService;
  Timer? _debounce;

  SearchUserViewNotifier(this._userService)
      : super(SearchUserViewState(searchController: TextEditingController()));

  Future<void> _search(String searchKey) async {
    try {
      if (searchKey.isEmpty) {
        state = state.copyWith(searchedUsers: [], error: null);
        return;
      }
      final users = await _userService.searchUser(searchKey);
      state = state.copyWith(searchedUsers: users);
    } catch (e) {
      state = state.copyWith(error: e);
      debugPrint("SearchUserViewNotifier: error while search user -> $e");
    }
  }

  void onSearchChanged() {
    if (_debounce != null && _debounce!.isActive) {
      _debounce!.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      _search(state.searchController.text.trim());
    });
  }

  void selectUser(UserModel user) {
    state = state.copyWith(selectedUser: user);
  }

  @override
  void dispose() {
    state.searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }
}

@freezed
class SearchUserViewState with _$SearchUserViewState {
  const factory SearchUserViewState({
    required TextEditingController searchController,
    Object? error,
    UserModel? selectedUser,
    @Default([]) List<UserModel> searchedUsers,
  }) = _SearchUserViewState;
}
