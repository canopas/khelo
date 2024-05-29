import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/score_board/score_board_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class ScoreBoardButtons extends StatelessWidget {
  final Function(ScoreButton) onTap;

  const ScoreBoardButtons({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: context.colorScheme.containerLow,
        padding: EdgeInsets.only(
            top: 24,
            bottom: MediaQuery.of(context).viewPadding.bottom + 16,
            left: 16,
            right: 8),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        Expanded(
                            child: _scoreButton(
                          context: context,
                          btn: ScoreButton.zero,
                          backgroundColor: context.colorScheme.containerLow,
                        )),
                        Expanded(
                            child: _scoreButton(
                          context: context,
                          btn: ScoreButton.one,
                          backgroundColor: context.colorScheme.containerLow,
                        )),
                        Expanded(
                            child: _scoreButton(
                          context: context,
                          btn: ScoreButton.two,
                          backgroundColor: context.colorScheme.containerLow,
                        )),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        Expanded(
                            child: _scoreButton(
                          context: context,
                          btn: ScoreButton.three,
                          backgroundColor: context.colorScheme.containerLow,
                        )),
                        Expanded(
                            child: _scoreButton(
                          context: context,
                          btn: ScoreButton.four,
                          backgroundColor: context.colorScheme.containerLow,
                        )),
                        Expanded(
                            child: _scoreButton(
                          context: context,
                          btn: ScoreButton.six,
                          backgroundColor: context.colorScheme.containerLow,
                        )),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Expanded(
                            child: _scoreButton(
                          context: context,
                          btn: ScoreButton.wideBall,
                        )),
                        Expanded(
                            child: _scoreButton(
                          context: context,
                          btn: ScoreButton.noBall,
                        )),
                        Expanded(
                            child: _scoreButton(
                          context: context,
                          btn: ScoreButton.bye,
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Expanded(
                      child: _scoreButton(
                    context: context,
                    btn: ScoreButton.undo,
                    tintColor: context.colorScheme.positive,
                  )),
                  Expanded(
                      child: _scoreButton(
                    context: context,
                    btn: ScoreButton.fiveOrSeven,
                  )),
                  Expanded(
                      child: _scoreButton(
                    context: context,
                    btn: ScoreButton.out,
                    tintColor: context.colorScheme.alert,
                  )),
                  Expanded(
                      child: _scoreButton(
                    context: context,
                    btn: ScoreButton.legBye,
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _scoreButton({
    required BuildContext context,
    required ScoreButton btn,
    Color? tintColor,
    Color? backgroundColor,
  }) {
    return OnTapScale(
      onTap: () => onTap(btn),
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(bottom: 8, right: 8),
        decoration: BoxDecoration(
            color: backgroundColor ?? context.colorScheme.surface,
            borderRadius: BorderRadius.circular(8)),
        child: Text.rich(
          TextSpan(text: btn.getTitle(context), children: [
            if (btn == ScoreButton.four || btn == ScoreButton.six) ...[
              TextSpan(
                  text: btn == ScoreButton.four
                      ? "\n${context.l10n.score_board_four_title}"
                      : "\n${context.l10n.score_board_six_title}",
                  style: AppTextStyle.body1.copyWith(
                      color: tintColor ?? context.colorScheme.textDisabled)),
            ]
          ]),
          textAlign: TextAlign.center,
          style: AppTextStyle.subtitle1
              .copyWith(color: tintColor ?? context.colorScheme.textDisabled),
        ),
      ),
    );
  }
}
