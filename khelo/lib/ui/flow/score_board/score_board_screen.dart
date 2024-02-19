import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/ui/flow/score_board/components/score_board_buttons.dart';
import 'package:khelo/ui/flow/score_board/score_board_view_model.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class ScoreBoardScreen extends ConsumerWidget {
  const ScoreBoardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(scoreBoardStateProvider.notifier);

    return AppPage(
      title: "Score Board",
      body: Padding(
        padding: context.mediaQueryPadding,
        child: Column(
          children: [
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '0/0',
                      style: AppTextStyle.subtitle1.copyWith(
                          color: context.colorScheme.textPrimary, fontSize: 39),
                    ),
                    TextSpan(
                      text: ' (0/2)',
                      style: AppTextStyle.header4
                          .copyWith(color: context.colorScheme.textSecondary),
                    ),
                  ],
                ),
              ),
              // TODO: if second innings then show "Need __ in __"
            ),
            Expanded(
                child: Row(
              children: [
                _batManInfoView(context, true),
                _batManInfoView(context, false),
              ],
            )),
            Expanded(
                child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: context.colorScheme.secondaryVariant,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        WidgetSpan(
                            child: Icon(
                          Icons.sports_baseball_outlined,
                          color: Colors.white,
                        )),
                        TextSpan(
                          text: ' Aakash',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  // TODO: per ball state for each ball of current bowler
                ],
              ),
            )),
            ScoreBoardButtons(
              onTap: (btn) => notifier.onScoreButtonTap(btn),
            )
          ],
        ),
      ),
    );
  }

  Widget _batManInfoView(
    BuildContext context,
    bool isOnStrike,
  ) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.sports_cricket,
                  color: isOnStrike
                      ? context.colorScheme.primary
                      : context.colorScheme.textDisabled,
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Vishal",
                    style: AppTextStyle.header1
                        .copyWith(color: context.colorScheme.textPrimary),
                  ),
                  Text(
                    "0(0)",
                    style: AppTextStyle.header4
                        .copyWith(color: context.colorScheme.textSecondary),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
