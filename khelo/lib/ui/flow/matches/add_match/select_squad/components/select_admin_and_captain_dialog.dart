import 'package:data/api/match/match_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/user_detail_cell.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/matches/add_match/select_squad/components/user_detail_sheet.dart';
import 'package:khelo/ui/flow/matches/add_match/select_squad/select_squad_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/button/bottom_sticky_overlay.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class SelectAdminAndCaptainDialog extends ConsumerWidget {
  static Future<T?> show<T>(BuildContext context) {
    HapticFeedback.mediumImpact();
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      useRootNavigator: true,
      backgroundColor: context.colorScheme.surface,
      builder: (context) {
        return const SelectAdminAndCaptainDialog();
      },
    );
  }

  const SelectAdminAndCaptainDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(selectSquadStateProvider.notifier);
    final state = ref.watch(selectSquadStateProvider);

    return SizedBox(
      height: context.mediaQuerySize.height * 0.8,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                child: Text(
                  context.l10n.select_squad_select_admin_captain_title,
                  style: AppTextStyle.header4
                      .copyWith(color: context.colorScheme.textPrimary),
                ),
              ),
              Expanded(child: _selectCaptainContent(context, notifier, state)),
            ],
          ),
          _stickyButton(context, state),
        ],
      ),
    );
  }

  Widget _selectCaptainContent(
    BuildContext context,
    SelectSquadViewNotifier notifier,
    SelectSquadViewState state,
  ) {
    return ListView.separated(
      itemCount: state.squad.length,
      padding: BottomStickyOverlay.padding,
      separatorBuilder: (context, index) => Divider(
        color: context.colorScheme.outline,
        height: 32,
      ),
      itemBuilder: (context, index) {
        final member = state.squad[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: UserDetailCell(
            user: member.player,
            onTap: () => UserDetailSheet.show(context, member.player),
            trailing: _selectButtons(context, notifier, state, member),
          ),
        );
      },
    );
  }

  Widget _selectButtons(
    BuildContext context,
    SelectSquadViewNotifier notifier,
    SelectSquadViewState state,
    MatchPlayer member,
  ) {
    return Wrap(
      direction: Axis.horizontal,
      spacing: 8,
      children: [
        _captainAdminButton(
          context,
          title: context.l10n.select_squad_captain_short_title,
          isSelected: state.captainId == member.player.id,
          onTap: () => notifier.onCaptainOrAdminSelect(
            PlayerMatchRole.captain,
            member.player.id,
          ),
        ),
        _captainAdminButton(
          context,
          title: context.l10n.common_a_title,
          isSelected: state.adminId == member.player.id,
          onTap: () => notifier.onCaptainOrAdminSelect(
            PlayerMatchRole.admin,
            member.player.id,
          ),
        ),
      ],
    );
  }

  Widget _captainAdminButton(
    BuildContext context, {
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return OnTapScale(
        onTap: () {
          if (!isSelected) {
            onTap();
          }
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isSelected
                ? context.colorScheme.primary
                : context.colorScheme.containerLow,
            shape: BoxShape.circle,
          ),
          child: Text(
            title,
            style: AppTextStyle.caption.copyWith(
                color: isSelected
                    ? context.colorScheme.textInversePrimary
                    : context.colorScheme.textDisabled),
          ),
        ));
  }

  Widget _stickyButton(BuildContext context, SelectSquadViewState state) {
    return BottomStickyOverlay(
      child: PrimaryButton(
        context.l10n.common_okay_title,
        enabled: state.isOkayBtnEnable,
        onPressed: () => context.pop({
          "captain_id": state.captainId,
          "admin_id": state.adminId,
        }),
      ),
    );
  }
}
