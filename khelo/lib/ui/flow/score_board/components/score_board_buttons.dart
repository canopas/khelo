import 'package:flutter/cupertino.dart';
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
        flex: 3,
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
                        )),
                        Expanded(
                            child: _scoreButton(
                          context: context,
                          btn: ScoreButton.one,
                        )),
                        Expanded(
                            child: _scoreButton(
                          context: context,
                          btn: ScoreButton.two,
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
                        )),
                        Expanded(
                            child: _scoreButton(
                          context: context,
                          btn: ScoreButton.four,
                        )),
                        Expanded(
                            child: _scoreButton(
                          context: context,
                          btn: ScoreButton.six,
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
                          backgroundColor:
                              context.colorScheme.containerHighOnSurface,
                        )),
                        Expanded(
                            child: _scoreButton(
                          context: context,
                          btn: ScoreButton.noBall,
                          backgroundColor:
                              context.colorScheme.containerHighOnSurface,
                        )),
                        Expanded(
                            child: _scoreButton(
                          context: context,
                          btn: ScoreButton.bye,
                          backgroundColor:
                              context.colorScheme.containerHighOnSurface,
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
                    backgroundColor: context.colorScheme.containerHighOnSurface,
                  )),
                  Expanded(
                      child: _scoreButton(
                    context: context,
                    btn: ScoreButton.fiveOrSeven,
                    backgroundColor: context.colorScheme.containerHighOnSurface,
                  )),
                  Expanded(
                      child: _scoreButton(
                    context: context,
                    btn: ScoreButton.out,
                    tintColor: context.colorScheme.alert,
                    backgroundColor: context.colorScheme.containerHighOnSurface,
                  )),
                  Expanded(
                      child: _scoreButton(
                    context: context,
                    btn: ScoreButton.legBye,
                    backgroundColor: context.colorScheme.containerHighOnSurface,
                  ))
                ],
              ),
            ),
          ],
        ));
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
        decoration: BoxDecoration(
            color: backgroundColor ?? context.colorScheme.containerLowOnSurface,
            border: Border.all(
                color: context.colorScheme.outline)),
        child: Text(
          btn.getTitle(context),
          style: AppTextStyle.header1
              .copyWith(color: tintColor ?? context.colorScheme.textSecondary),
        ),
      ),
    );
  }
}
