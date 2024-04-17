import 'package:data/api/team/team_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/score_board/score_board_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class AddPenaltyRunDialog extends ConsumerStatefulWidget {
  static Future<T?> show<T>(
    BuildContext context,
  ) {
    return showAdaptiveDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return const AddPenaltyRunDialog();
      },
    );
  }

  const AddPenaltyRunDialog({super.key});

  @override
  ConsumerState createState() => _AddPenaltyRunDialogState();
}

class _AddPenaltyRunDialogState extends ConsumerState<AddPenaltyRunDialog> {
  String? selectedTeamId;

  bool isButtonEnable = false;
  TextEditingController runController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(scoreBoardStateProvider);
    return Material(
      type: MaterialType.transparency,
      color: Colors.transparent,
      child: AlertDialog.adaptive(
        backgroundColor: context.colorScheme.containerLowOnSurface,
        title: Text(
          context.l10n.score_board_penalty_run_title,
          style: AppTextStyle.subtitle1
              .copyWith(color: context.colorScheme.textPrimary),
        ),
        content: _addPenaltyContent(context, state),
        actionsAlignment: MainAxisAlignment.spaceAround,
        actions: [
          PrimaryButton(
            context.l10n.common_okay_title,
            enabled: isButtonEnable,
            onPressed: () {
              context.pop((
                teamId: selectedTeamId,
                runs: int.parse(runController.text),
              ));
            },
          ),
        ],
      ),
    );
  }

  Widget _addPenaltyContent(BuildContext context, ScoreBoardViewState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 70,
              child: TextField(
                style: AppTextStyle.subtitle1
                    .copyWith(color: context.colorScheme.textPrimary),
                textAlign: TextAlign.center,
                controller: runController,
                onChanged: (value) {
                  setState(() {
                    isButtonEnable = value.isNotEmpty && selectedTeamId != null;
                  });
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                decoration: InputDecoration(
                  fillColor: context.colorScheme.surface,
                  filled: true,
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              context.l10n.score_board_runs_title,
              style: AppTextStyle.subtitle2
                  .copyWith(color: context.colorScheme.textPrimary),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        _chooseTeamForPenaltyRun(context, state)
      ],
    );
  }

  Widget _chooseTeamForPenaltyRun(
    BuildContext context,
    ScoreBoardViewState state,
  ) {
    return Row(
      children: [
        _teamCell(
          context: context,
          state: state,
          team: state.match?.teams.first.team,
        ),
        const SizedBox(
          width: 16,
        ),
        _teamCell(
          context: context,
          state: state,
          team: state.match?.teams.last.team,
        ),
      ],
    );
  }

  Widget _teamCell({
    required BuildContext context,
    required ScoreBoardViewState state,
    TeamModel? team,
  }) {
    final name = team?.name;
    final imgUrl = team?.profile_img_url;
    final initial = team?.name[0].toUpperCase();
    final isSelected = selectedTeamId == team?.id;

    return Expanded(
      child: OnTapScale(
        onTap: () {
          setState(() {
            selectedTeamId = team?.id;
            isButtonEnable =
                runController.text.isNotEmpty && selectedTeamId != null;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected
                ? context.colorScheme.positive.withOpacity(0.1)
                : context.colorScheme.containerNormalOnSurface,
            border: Border.all(
                color: isSelected
                    ? context.colorScheme.positive
                    : context.colorScheme.outline),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ImageAvatar(
                imageUrl: imgUrl,
                initial: initial ?? "?",
                size: 60,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                name ?? "",
                style: AppTextStyle.subtitle1
                    .copyWith(color: context.colorScheme.textPrimary),
              )
            ],
          ),
        ),
      ),
    );
  }
}
