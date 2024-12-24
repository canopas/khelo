import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khelo/components/error_snackbar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/matches/add_match/add_match_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class OverDetailView extends StatelessWidget {
  final AddMatchViewNotifier notifier;
  final AddMatchViewState state;

  const OverDetailView({
    super.key,
    required this.notifier,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: context.colorScheme.outline)),
      child: Column(
        children: [
          _detailCellView(context,
              title: context.l10n.add_match_no_of_over_title,
              trailing: _stepperView(
                context,
                state.totalOverController,
                onChanged: notifier.onTextChange,
                onStepperActionTap: (isAdd) => notifier.onStepperActionTap(
                    isForTotalOverCount: true, isAdd: isAdd),
              )),
          const SizedBox(height: 8),
          _detailCellView(context,
              title: context.l10n.add_match_over_per_bowler_title,
              trailing: _stepperView(
                context,
                state.overPerBowlerController,
                onChanged: notifier.onTextChange,
                onStepperActionTap: (isAdd) => notifier.onStepperActionTap(
                    isForTotalOverCount: false, isAdd: isAdd),
              )),
          const SizedBox(height: 8),
          _detailCellView(
            context,
            title: context.l10n.common_power_play_title,
            trailing: _powerPlayCount(context, notifier, state),
            onTap: () async {
              if (state.isPowerPlayButtonEnable) {
                final res = await AppRoute.powerPlay(
                        totalOvers: int.parse(state.totalOverController.text),
                        firstPowerPlay: state.firstPowerPlay,
                        secondPowerPlay: state.secondPowerPlay,
                        thirdPowerPlay: state.thirdPowerPlay)
                    .push<List<List<int>>>(context);
                if (res != null && context.mounted) {
                  notifier.onPowerPlayChange(res);
                }
              } else {
                showErrorSnackBar(
                    context: context,
                    error:
                        AddMatchErrorType.invalidOverCount.getString(context));
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _detailCellView(
    BuildContext context, {
    required String title,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return OnTapScale(
      onTap: onTap,
      enabled: onTap != null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: AppTextStyle.subtitle3
                    .copyWith(color: context.colorScheme.textPrimary),
              ),
            ),
            trailing
          ],
        ),
      ),
    );
  }

  Widget _powerPlayCount(
    BuildContext context,
    AddMatchViewNotifier notifier,
    AddMatchViewState state,
  ) {
    return Text(
      _getPowerPlayCount(state).toString(),
      style: AppTextStyle.subtitle1
          .copyWith(color: context.colorScheme.textPrimary),
    );
  }

  int _getPowerPlayCount(AddMatchViewState state) {
    final count = [
      state.firstPowerPlay,
      state.secondPowerPlay,
      state.thirdPowerPlay
    ].where((play) => play != null && play.isNotEmpty).length;
    return count;
  }

  Widget _stepperView(
    BuildContext context,
    TextEditingController controller, {
    required VoidCallback onChanged,
    required Function(bool) onStepperActionTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: context.colorScheme.containerLowOnSurface,
      ),
      child: Row(
        children: [
          _stepperActionButton(
            context,
            isPlus: false,
            isEnabled: (int.tryParse(controller.text) ?? 0) > 1,
            onTap: () => onStepperActionTap(false),
          ),
          Material(
            color: Colors.transparent,
            child: IntrinsicWidth(
              child: TextField(
                controller: controller,
                textAlign: TextAlign.center,
                maxLength: 3,
                style: AppTextStyle.header4
                    .copyWith(color: context.colorScheme.primary),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    hintText: "0",
                    hintStyle: AppTextStyle.header4
                        .copyWith(color: context.colorScheme.primary),
                    counterText: ""),
                onChanged: (value) => onChanged(),
                onTapOutside: (event) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
              ),
            ),
          ),
          _stepperActionButton(
            context,
            isEnabled: (int.tryParse(controller.text) ?? 0) < 999,
            onTap: () => onStepperActionTap(true),
          )
        ],
      ),
    );
  }

  Widget _stepperActionButton(
    BuildContext context, {
    bool isPlus = true,
    bool isEnabled = true,
    required VoidCallback onTap,
  }) {
    return OnTapScale(
      onTap: onTap,
      enabled: isEnabled,
      child: Container(
        height: 34,
        width: 34,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: context.colorScheme.surface, shape: BoxShape.circle),
        child: Icon(
          isPlus ? Icons.add : Icons.remove,
          size: 18,
          color: isEnabled
              ? context.colorScheme.textPrimary
              : context.colorScheme.textDisabled,
        ),
      ),
    );
  }
}
