import 'package:data/api/user/user_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/error_screen.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/domain/formatter/string_formatter.dart';
import 'package:khelo/ui/flow/matches/add_match/match_officials/search_user/search_user_view_model.dart';
import 'package:khelo/ui/flow/matches/add_match/select_squad/components/user_detail_sheet.dart';
import 'package:khelo/ui/flow/team/add_team_member/components/verify_add_team_member_dialog.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class SearchUserBottomSheet extends ConsumerWidget {
  static Future<T?> show<T>(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      useRootNavigator: true,
      backgroundColor: context.colorScheme.surface,
      builder: (context) {
        return const SearchUserBottomSheet();
      },
    );
  }

  const SearchUserBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(searchUserStateProvider.notifier);
    final state = ref.watch(searchUserStateProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SizedBox(
        height: context.mediaQuerySize.height * 0.8,
        child: Column(
          children: [
            _searchTextField(context, notifier, state),
            Expanded(
              child: _body(context, notifier, state),
            ),
          ],
        ),
      ),
    );
  }

  Widget _body(
    BuildContext context,
    SearchUserViewNotifier notifier,
    SearchUserViewState state,
  ) {
    if (state.error != null) {
      return ErrorScreen(
        error: state.error,
        onRetryTap: notifier.onSearchChanged,
      );
    }

    return state.searchedUsers.isEmpty
        ? Center(
            child: Text(
              context.l10n.search_user_empty_text,
              textAlign: TextAlign.center,
              style: AppTextStyle.subtitle1.copyWith(
                color: context.colorScheme.textDisabled,
                fontSize: 20,
              ),
            ),
          )
        : ListView.separated(
            separatorBuilder: (context, index) {
              return const SizedBox(height: 16);
            },
            itemCount: state.searchedUsers.length,
            itemBuilder: (context, index) {
              UserModel user = state.searchedUsers[index];
              return _userProfileCell(context, notifier, state, user);
            },
          );
  }

  Widget _searchTextField(
    BuildContext context,
    SearchUserViewNotifier notifier,
    SearchUserViewState state,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Material(
        type: MaterialType.transparency,
        child: TextField(
          controller: state.searchController,
          onChanged: (value) => notifier.onSearchChanged(),
          decoration: InputDecoration(
            hintText: context.l10n.search_user_hint_title,
            contentPadding: const EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: context.colorScheme.containerLow,
            hintStyle: TextStyle(color: context.colorScheme.textDisabled),
            prefixIcon: Icon(
              Icons.search,
              color: context.colorScheme.textDisabled,
              size: 24,
            ),
          ),
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          style: AppTextStyle.body2.copyWith(
            color: context.colorScheme.textPrimary,
          ),
        ),
      ),
    );
  }

  Widget _userProfileCell(
    BuildContext context,
    SearchUserViewNotifier notifier,
    SearchUserViewState state,
    UserModel user,
  ) {
    return GestureDetector(
        onTap: () => UserDetailSheet.show(context, user),
        child: Row(
          children: [
            ImageAvatar(
              initial: user.nameInitial,
              imageUrl: user.profile_img_url,
              size: 50,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name ?? context.l10n.common_anonymous_title,
                    style: AppTextStyle.header4
                        .copyWith(color: context.colorScheme.textPrimary),
                  ),
                  Text(
                      user.player_role != null
                          ? user.player_role!.getString(context)
                          : context.l10n.common_not_specified_title,
                      style: AppTextStyle.subtitle2
                          .copyWith(color: context.colorScheme.textSecondary)),
                  if (user.phone != null) ...[
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      user.phone
                          .format(context, StringFormats.obscurePhoneNumber),
                      style: AppTextStyle.subtitle2
                          .copyWith(color: context.colorScheme.textSecondary),
                    ),
                  ],
                ],
              ),
            ),
            OnTapScale(
              onTap: () async {
                if (user.phone != null) {
                  final res = await VerifyAddTeamMemberDialog.show(context,
                      phoneNumber:
                          user.phone!.substring(user.phone!.length - 5));
                  if (res != null && res && context.mounted) {
                    context.pop(user);
                  }
                }
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                    color: context.colorScheme.containerLow,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(context.l10n.common_add_title.toUpperCase()),
              ),
            ),
          ],
        ));
  }
}
