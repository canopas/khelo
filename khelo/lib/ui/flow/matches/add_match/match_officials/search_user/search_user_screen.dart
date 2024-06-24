import 'package:data/api/user/user_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/error_screen.dart';
import 'package:khelo/components/user_detail_cell.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/matches/add_match/match_officials/search_user/search_user_view_model.dart';
import 'package:khelo/ui/flow/matches/add_match/select_squad/components/user_detail_sheet.dart';
import 'package:khelo/ui/flow/team/add_team_member/components/verify_team_member_sheet.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_field.dart';
import 'package:style/text/app_text_style.dart';

class SearchUserBottomSheet extends ConsumerWidget {
  static Future<T?> show<T>(BuildContext context) {
    HapticFeedback.mediumImpact();
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
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: context.mediaQuerySize.height * 0.8,
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
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Text(
                context.l10n.search_user_empty_text,
                textAlign: TextAlign.center,
                style: AppTextStyle.body1.copyWith(
                  color: context.colorScheme.textPrimary,
                ),
              ),
            ),
          )
        : ListView.separated(
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: AppTextField(
        controller: state.searchController,
        hintText: context.l10n.search_user_hint_title,
        hintStyle: AppTextStyle.subtitle3
            .copyWith(color: context.colorScheme.textDisabled),
        style: AppTextStyle.subtitle3
            .copyWith(color: context.colorScheme.textPrimary),
        borderRadius: BorderRadius.circular(30),
        borderType: AppTextFieldBorderType.outline,
        backgroundColor: context.colorScheme.containerLowOnSurface,
        borderColor: BorderColor(
          focusColor: Colors.transparent,
          unFocusColor: Colors.transparent,
        ),
        prefixIcon: Icon(
          CupertinoIcons.search,
          color: context.colorScheme.textDisabled,
        ),
        onChanged: (value) => notifier.onSearchChanged(),
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
      ),
    );
  }

  Widget _addButton(BuildContext context, UserModel user) {
    return OnTapScale(
      onTap: () async {
        if (user.phone != null) {
          final res = await VerifyTeamMemberSheet.show(context,
              phoneNumber: user.phone!);
          if (res != null && res && context.mounted) {
            context.pop(user);
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: context.colorScheme.containerLow,
            borderRadius: BorderRadius.circular(30)),
        child: Text(
          context.l10n.common_add_title,
          style: AppTextStyle.body2
              .copyWith(color: context.colorScheme.textDisabled),
        ),
      ),
    );
  }
}
