import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/string_extensions.dart';
import 'package:khelo/ui/flow/score_board/components/bottom_sheet_wrapper.dart';
import 'package:khelo/ui/flow/score_board/components/user_cell_view.dart';
import 'package:khelo/ui/flow/score_board/score_board_view_model.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_field.dart';
import 'package:style/text/app_text_style.dart';

class AddPenaltyRunSheet extends ConsumerStatefulWidget {
  static Future<T?> show<T>(BuildContext context) {
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
          child: const AddPenaltyRunSheet(),
        );
      },
    );
  }

  const AddPenaltyRunSheet({super.key});

  @override
  ConsumerState createState() => _AddPenaltyRunSheetState();
}

class _AddPenaltyRunSheetState extends ConsumerState<AddPenaltyRunSheet> {
  String? selectedTeamId;

  bool isButtonEnable = false;
  TextEditingController runController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(scoreBoardStateProvider);
    return BottomSheetWrapper(
      content: _addPenaltyContent(context, state),
      action: [
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
    );
  }

  Widget _addPenaltyContent(BuildContext context, ScoreBoardViewState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.score_board_penalty_run_title,
          style: AppTextStyle.header3
              .copyWith(color: context.colorScheme.textPrimary),
        ),
        const SizedBox(height: 16),
        _addRunsView(context, state),
      ],
    );
  }

  Widget _addRunsView(BuildContext context, ScoreBoardViewState state) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: context.colorScheme.containerLow,
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IntrinsicWidth(
                child: Container(
                  constraints: const BoxConstraints(minWidth: 70),
                  child: AppTextField(
                    controller: runController,
                    textAlign: TextAlign.center,
                    backgroundColor: context.colorScheme.surface,
                    borderType: AppTextFieldBorderType.outline,
                    maxLength: 2,
                    autoFocus: true,
                    borderRadius: BorderRadius.circular(8),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    borderColor: BorderColor(
                        focusColor: Colors.transparent,
                        unFocusColor: Colors.transparent),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    style: AppTextStyle.subtitle2
                        .copyWith(color: context.colorScheme.textPrimary),
                    onChanged: (value) => setState(() => isButtonEnable =
                        (int.tryParse(value) ?? 0) > 0 &&
                            selectedTeamId != null),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                context.l10n.score_board_runs_title,
                style: AppTextStyle.header3
                    .copyWith(color: context.colorScheme.textPrimary),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            context.l10n.score_board_awarded_to_text,
            style: AppTextStyle.subtitle2
                .copyWith(color: context.colorScheme.textPrimary),
          ),
          const SizedBox(height: 16),
          _chooseTeamForPenaltyRun(context, state),
        ],
      ),
    );
  }

  Widget _chooseTeamForPenaltyRun(
    BuildContext context,
    ScoreBoardViewState state,
  ) {
    final firstTeam = state.match?.teams.first.team;
    final secondTeam = state.match?.teams.last.team;
    return IntrinsicHeight(
      child: Row(
        children: [
          UserCellView(
            title: firstTeam?.name ?? "",
            imageUrl: firstTeam?.profile_img_url,
            outerPadding: 32,
            initial: firstTeam?.name_initial ??
                firstTeam?.name.initials(limit: 1) ??
                "?",
            isSelected: selectedTeamId == firstTeam?.id,
            onTap: () => setState(() {
              selectedTeamId = firstTeam?.id;
              isButtonEnable = (int.tryParse(runController.text) ?? 0) > 0 &&
                  selectedTeamId != null;
            }),
          ),
          const SizedBox(width: 16),
          UserCellView(
            title: secondTeam?.name ?? "",
            imageUrl: secondTeam?.profile_img_url,
            initial: secondTeam?.name_initial ??
                secondTeam?.name.initials(limit: 1) ??
                "?",
            outerPadding: 32,
            isSelected: selectedTeamId == secondTeam?.id,
            onTap: () => setState(() {
              selectedTeamId = secondTeam?.id;
              isButtonEnable = (int.tryParse(runController.text) ?? 0) > 0 &&
                  selectedTeamId != null;
            }),
          ),
        ],
      ),
    );
  }
}
