import 'package:data/api/match/match_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/domain/formatter/string_formatter.dart';
import 'package:khelo/ui/flow/matches/add_match/select_squad/select_squad_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class SelectAdminAndCaptainDialog extends ConsumerWidget {
  static Future<T?> show<T>(BuildContext context) {
    return showDialog(
      context: context,
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

    return AlertDialog(
      backgroundColor: context.colorScheme.containerLowOnSurface,
      title: Text(
        context.l10n.select_squad_select_admin_captain_title,
        style: AppTextStyle.subtitle1
            .copyWith(color: context.colorScheme.textPrimary),
      ),
      content: _selectCaptainContent(context, notifier, state),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        OnTapScale(
            onTap: () => context.pop({
                  "captain_id": state.captainId,
                  "admin_id": state.adminId,
                }),
            enabled: state.isOkayBtnEnable,
            child: Text(
              context.l10n.common_okay_title,
              style: AppTextStyle.subtitle1.copyWith(
                  color: state.isOkayBtnEnable
                      ? context.colorScheme.primary
                      : context.colorScheme.textDisabled),
            )),
      ],
    );
  }

  Widget _selectCaptainContent(
    BuildContext context,
    SelectSquadViewNotifier notifier,
    SelectSquadViewState state,
  ) {
    return SingleChildScrollView(
      child: Wrap(
        runSpacing: 16,
        children: [
          for (final member in state.squad) ...[
            _userProfileCell(context, notifier, state, member),
          ],
        ],
      ),
    );
  }

  Widget _userProfileCell(
    BuildContext context,
    SelectSquadViewNotifier notifier,
    SelectSquadViewState state,
    MatchPlayer member,
  ) {
    return Row(
      children: [
        ImageAvatar(
          initial: member.player.nameInitial,
          imageUrl: member.player.profile_img_url,
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
                member.player.name ?? context.l10n.common_anonymous_title,
                style: AppTextStyle.header4
                    .copyWith(color: context.colorScheme.textPrimary),
              ),
              Text(
                  member.player.player_role != null
                      ? member.player.player_role!.getString(context)
                      : context.l10n.common_not_specified_title,
                  style: AppTextStyle.subtitle2
                      .copyWith(color: context.colorScheme.textSecondary)),
              if (member.player.phone != null) ...[
                const SizedBox(
                  height: 2,
                ),
                Text(
                  member.player.phone
                      .format(context, StringFormats.obscurePhoneNumber),
                  style: AppTextStyle.subtitle2
                      .copyWith(color: context.colorScheme.textSecondary),
                ),
              ],
            ],
          ),
        ),
        _selectButtons(context, notifier, state, member)
      ],
    );
  }

  Widget _selectButtons(BuildContext context, SelectSquadViewNotifier notifier,
      SelectSquadViewState state, MatchPlayer member) {
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
          title: context.l10n.select_squad_admin_short_title,
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
    required Function() onTap,
  }) {
    return OnTapScale(
        onTap: () {
          if (!isSelected) {
            onTap();
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: context.colorScheme.textPrimary),
            color: isSelected ? context.colorScheme.primary : null,
            shape: BoxShape.circle,
          ),
          child: Text(
            title,
            style: AppTextStyle.subtitle1
                .copyWith(color: context.colorScheme.textPrimary),
          ),
        ));
  }
}
