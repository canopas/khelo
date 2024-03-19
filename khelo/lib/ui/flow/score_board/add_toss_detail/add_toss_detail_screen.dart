import 'package:data/api/match/match_model.dart';
import 'package:data/api/team/team_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/domain/extensions/widget_extension.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/score_board/add_toss_detail/add_toss_detail_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/button/bottom_sticky_overlay.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';

class AddTossDetailScreen extends ConsumerStatefulWidget {
  final String matchId;

  const AddTossDetailScreen({super.key, required this.matchId});

  @override
  ConsumerState createState() => _AddTossDetailScreenState();
}

class _AddTossDetailScreenState extends ConsumerState<AddTossDetailScreen> {
  late AddTossDetailViewNotifier notifier;

  @override
  void initState() {
    super.initState();
    notifier = ref.read(addTossDetailStateProvider.notifier);
    runPostFrame(() => notifier.setData(widget.matchId));
  }

  void _observePushScoreBoard() {
    ref.listen(
        addTossDetailStateProvider.select((value) => value.pushScoreBoard),
        (previous, next) {
      if (next != null && next) {
        AppRoute.scoreBoard(matchId: notifier.matchId!)
            .pushReplacement(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    notifier = ref.watch(addTossDetailStateProvider.notifier);
    final state = ref.watch(addTossDetailStateProvider);

    _observePushScoreBoard();
    return AppPage(
      title: context.l10n.add_toss_detail_screen_title,
      body: _body(notifier, state),
    );
  }

  Widget _body(AddTossDetailViewNotifier notifier, AddTossDetailState state) {
    if (state.loading) {
      return const Center(child: AppProgressIndicator());
    }

    return Stack(
      children: [
        ListView(
          padding: context.mediaQueryPadding +
              const EdgeInsets.symmetric(horizontal: 16) +
              BottomStickyOverlay.padding,
          children: [
            _whoWonTossView(notifier, state),
            _electedToView(notifier, state),
          ],
        ),
        _stickyButton(context, notifier, state)
      ],
    );
  }

  Widget _whoWonTossView(
    AddTossDetailViewNotifier notifier,
    AddTossDetailState state,
  ) {
    return Wrap(
      children: [
        _sectionTitle(context, context.l10n.add_toss_detail_who_won_toss_text),
        Row(
          children: [
            _teamCell(
              context: context,
              notifier: notifier,
              state: state,
              team: state.match?.teams.first.team,
            ),
            const SizedBox(
              width: 16,
            ),
            _teamCell(
              context: context,
              notifier: notifier,
              state: state,
              team: state.match?.teams.last.team,
            ),
          ],
        )
      ],
    );
  }

  Widget _electedToView(
    AddTossDetailViewNotifier notifier,
    AddTossDetailState state,
  ) {
    return Wrap(
      children: [
        _sectionTitle(
            context, context.l10n.add_toss_detail_winner_elected_to_text),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: (TossDecision.values)
              .map((decision) => _tossDecisionCell(
                    context: context,
                    image: getTossDecisionImage(decision),
                    title: decision.getString(context),
                    isSelected: state.tossWinnerDecision == decision,
                    onTap: () {
                      notifier.onOptionSelect(decision);
                    },
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _sectionTitle(BuildContext context, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 24,
        ),
        Text(
          title,
          style: AppTextStyle.header1
              .copyWith(color: context.colorScheme.textSecondary),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget _teamCell({
    required BuildContext context,
    required AddTossDetailViewNotifier notifier,
    required AddTossDetailState state,
    TeamModel? team,
  }) {
    final name = team?.name;
    final imgUrl = team?.profile_img_url;
    final initial = team?.name[0].toUpperCase();
    final isSelected = state.tossWinnerTeamId == team?.id;

    return Expanded(
      child: OnTapScale(
        onTap: () {
          notifier.onTossWinnerSelect(team?.id ?? "INVALID ID");
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
            crossAxisAlignment: CrossAxisAlignment.center,
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
                textAlign: TextAlign.center,
                style: AppTextStyle.subtitle1
                    .copyWith(color: context.colorScheme.textPrimary),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _tossDecisionCell({
    required BuildContext context,
    required String image,
    required String title,
    required bool isSelected,
    required Function() onTap,
  }) {
    return Expanded(
      child: OnTapScale(
        onTap: () => onTap(),
        child: Column(
          children: [
            Container(
              height: 140,
              width: 140,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: isSelected
                      ? Border.all(color: context.colorScheme.positive)
                      : null,
                  color: isSelected
                      ? context.colorScheme.positive.withOpacity(0.1)
                      : context.colorScheme.containerNormalOnSurface),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                color: context.colorScheme.textDisabled,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              title,
              style: AppTextStyle.subtitle1
                  .copyWith(color: context.colorScheme.textPrimary),
            )
          ],
        ),
      ),
    );
  }

  Widget _stickyButton(BuildContext context, AddTossDetailViewNotifier notifier,
      AddTossDetailState state) {
    return BottomStickyOverlay(
      child: PrimaryButton(
        context.l10n.common_next_title,
        enabled: state.isButtonEnable,
        progress: state.isTossDetailUpdateInProgress,
        onPressed: () => notifier.onNextButtonTap(),
      ),
    );
  }

  String getTossDecisionImage(TossDecision decision) {
    switch (decision) {
      case TossDecision.bat:
        return "assets/images/ic_batsman.png";
      case TossDecision.bowl:
        return "assets/images/ic_bowler.png";
    }
  }
}
