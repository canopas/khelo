import 'package:data/api/user/user_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/empty_screen.dart';
import 'package:khelo/components/error_screen.dart';
import 'package:khelo/components/user_detail_cell.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/widget_extension.dart';
import 'package:khelo/ui/flow/matches/add_match/select_squad/components/user_detail_sheet.dart';
import 'package:khelo/ui/flow/score_board/add_substitute_sheet/add_substitute_view_model.dart';
import 'package:khelo/ui/flow/score_board/components/user_cell_view.dart';
import 'package:khelo/ui/flow/team/add_team_member/components/verify_team_member_sheet.dart';
import 'package:style/button/bottom_sticky_overlay.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/button/secondary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';
import 'package:style/text/search_text_field.dart';

class AddSubstituteSheet extends ConsumerStatefulWidget {
  static Future<T?> show<T>(
    BuildContext context, {
    required List<String> playingSquadIds,
    required List<UserModel> nonPlayingMembers,
  }) {
    HapticFeedback.mediumImpact();
    return showModalBottomSheet(
      context: context,
      showDragHandle: false,
      enableDrag: false,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: context.colorScheme.surface,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: AddSubstituteSheet(
            nonPlayingMembers: nonPlayingMembers,
            playingSquadIds: playingSquadIds,
          ),
        );
      },
    );
  }

  final List<String> playingSquadIds;
  final List<UserModel> nonPlayingMembers;

  const AddSubstituteSheet({
    super.key,
    required this.playingSquadIds,
    required this.nonPlayingMembers,
  });

  @override
  ConsumerState createState() => _AddSubstituteSheetState();
}

class _AddSubstituteSheetState extends ConsumerState<AddSubstituteSheet> {
  UserModel? selectedPlayer;
  bool isEnabled = false;
  late List<UserModel> playerList;
  late AddSubstituteViewNotifier notifier;

  @override
  void initState() {
    super.initState();
    notifier = ref.read(addSubstituteStateProvider.notifier);

    runPostFrame(() => notifier.setData(
          widget.nonPlayingMembers,
          widget.playingSquadIds,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addSubstituteStateProvider);

    return Container(
      height: context.mediaQuerySize.height * 0.8,
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 44) +
                const EdgeInsets.symmetric(horizontal: 16.0) +
                context.mediaQueryPadding,
            child: CustomScrollView(
              slivers: _content(context, state),
            ),
          ),
          _dragHandle(context),
          if (state.error == null) _stickyButton(context),
        ],
      ),
    );
  }

  Widget _dragHandle(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 4,
        width: 32,
        margin: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
            color: context.colorScheme.outline,
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _stickyButton(BuildContext context) {
    return BottomStickyOverlay(
      child: PrimaryButton(
        context.l10n.common_select_title,
        enabled: selectedPlayer != null,
        onPressed: () => context.pop(selectedPlayer),
      ),
    );
  }

  List<Widget> _content(BuildContext context, AddSubstituteViewState state) {
    if (state.error != null) {
      return [
        SliverToBoxAdapter(
          child: Padding(
            padding: BottomStickyOverlay.padding,
            child: ErrorScreen(
              error: state.error,
              onRetryTap: notifier.onSearchChanged,
            ),
          ),
        )
      ];
    }
    return [
      SliverPadding(
        padding: BottomStickyOverlay.padding,
        sliver: SliverMainAxisGroup(slivers: [
          SliverToBoxAdapter(
            child: Text(
              context.l10n.score_board_add_substitute_title,
              style: AppTextStyle.header3
                  .copyWith(color: context.colorScheme.textPrimary),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverToBoxAdapter(
              child: _benchPlayerView(context, state.nonPlayingPlayers)),
          SliverToBoxAdapter(child: _searchTextField(context, notifier, state)),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          SliverFillRemaining(
              hasScrollBody: false,
              child: _searchResultView(context, notifier, state)),
        ]),
      )
    ];
  }

  Widget _benchPlayerView(BuildContext context, List<UserModel> bench) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: bench.map((player) {
          return Padding(
            padding: const EdgeInsets.only(right: 16, bottom: 16),
            child: UserCellView(
              title: player.name ?? context.l10n.common_anonymous_title,
              imageUrl: player.profile_img_url,
              initial: player.nameInitial,
              isSelected: selectedPlayer?.id == player.id,
              onTap: () => setState(() => selectedPlayer = player),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _searchResultView(
    BuildContext context,
    AddSubstituteViewNotifier notifier,
    AddSubstituteViewState state,
  ) {
    return state.searchedUsers.isEmpty
        ? EmptyScreen(
            title: (state.searchController.text.isNotEmpty)
                ? context.l10n.add_team_member_search_no_result_title
                : context.l10n.add_substitute_search_substitute_title,
            description: (state.searchController.text.isNotEmpty)
                ? context.l10n.add_team_member_search_description_text
                : context.l10n.add_substitute_search_substitute_description,
            isShowButton: false,
          )
        : Column(
            children: state.searchedUsers.map(
              (user) {
                final enableAction = !state.playingSquadIds.contains(user.id);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: UserDetailCell(
                    user: user,
                    trailing: _addButton(context, user, enableAction),
                    onTap: () => UserDetailSheet.show(
                      context,
                      user,
                      actionButtonTitle: enableAction
                          ? context.l10n.common_select_title
                          : null,
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
            ).toList(),
          );
  }

  Widget _searchTextField(
    BuildContext context,
    AddSubstituteViewNotifier notifier,
    AddSubstituteViewState state,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SearchTextField(
        controller: state.searchController,
        hintText: context.l10n.search_user_hint_title,
        onChange: notifier.onSearchChanged,
      ),
    );
  }

  Widget _addButton(BuildContext context, UserModel user, bool enabled) {
    return SecondaryButton(
      context.l10n.common_select_title,
      enabled: enabled,
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