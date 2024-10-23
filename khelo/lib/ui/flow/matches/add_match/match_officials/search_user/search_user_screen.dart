import 'package:data/api/user/user_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/empty_screen.dart';
import 'package:khelo/components/error_screen.dart';
import 'package:khelo/components/user_detail_cell.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/matches/add_match/match_officials/search_user/search_user_view_model.dart';
import 'package:khelo/ui/flow/matches/add_match/select_squad/components/user_detail_sheet.dart';
import 'package:khelo/ui/flow/team/add_team_member/components/verify_team_member_sheet.dart';
import 'package:style/button/secondary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/search_text_field.dart';

class SearchUserBottomSheet extends ConsumerWidget {
  static Future<T?> show<T>(
    BuildContext context, {
    String? emptyScreenTitle,
    String? emptyScreenDescription,
  }) {
    HapticFeedback.mediumImpact();
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      useRootNavigator: true,
      backgroundColor: context.colorScheme.surface,
      builder: (context) {
        return SearchUserBottomSheet(
          emptyScreenTitle: emptyScreenTitle,
          emptyScreenDescription: emptyScreenDescription,
        );
      },
    );
  }

  final String? emptyScreenTitle;
  final String? emptyScreenDescription;

  const SearchUserBottomSheet({
    super.key,
    this.emptyScreenTitle,
    this.emptyScreenDescription,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(searchUserStateProvider.notifier);
    final state = ref.watch(searchUserStateProvider);

    return SizedBox(
      height: context.mediaQuerySize.height * 0.8,
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          children: [
            _searchTextField(context, notifier, state),
            Expanded(child: _body(context, notifier, state)),
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
        ? EmptyScreen(
            title: (state.searchController.text.isNotEmpty)
                ? context.l10n.add_team_member_search_no_result_title
                : emptyScreenTitle ?? context.l10n.search_user_empty_title,
            description: (state.searchController.text.isNotEmpty)
                ? context.l10n.add_team_member_search_description_text
                : emptyScreenDescription ??
                    context.l10n.search_user_empty_description_text,
            isShowButton: false,
          )
        : ListView.separated(
            padding: const EdgeInsets.only(top: 16, bottom: 40),
            separatorBuilder: (context, index) {
              return Divider(
                color: context.colorScheme.outline,
                height: 32,
              );
            },
            itemCount: state.searchedUsers.length,
            itemBuilder: (context, index) {
              UserModel user = state.searchedUsers[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: UserDetailCell(
                  user: user,
                  trailing: _addButton(context, user),
                  onTap: () => UserDetailSheet.show(
                    context,
                    user,
                    actionButtonTitle: context.l10n.common_add_title,
                    onButtonTap: () async {
                      if (user.phone != null) {
                        final res = await VerifyTeamMemberSheet.show(context,
                            phoneNumber: user.phone!);
                        if (res != null && res && context.mounted) {
                          context.pop(user);
                        }
                      }
                    },
                  ),
                ),
              );
            },
          );
  }

  Widget _searchTextField(
    BuildContext context,
    SearchUserViewNotifier notifier,
    SearchUserViewState state,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SearchTextField(
        controller: state.searchController,
        hintText: context.l10n.search_user_hint_title,
        onChange: notifier.onSearchChanged,
      ),
    );
  }

  Widget _addButton(BuildContext context, UserModel user) {
    return SecondaryButton(
      context.l10n.common_add_title,
      onPressed: () async {
        if (user.phone != null) {
          final res = await VerifyTeamMemberSheet.show(context,
              phoneNumber: user.phone!);
          if (res != null && res && context.mounted) {
            context.pop(user);
          }
        }
      },
    );
  }
}
