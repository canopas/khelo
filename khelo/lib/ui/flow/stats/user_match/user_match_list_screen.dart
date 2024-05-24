import 'package:data/api/match/match_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khelo/components/error_screen.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/components/won_by_message_text.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/data_model_extensions/match_model_extension.dart';
import 'package:khelo/domain/formatter/date_formatter.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/stats/user_match/user_match_list_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';

import '../../../../gen/assets.gen.dart';

class UserMatchListScreen extends ConsumerStatefulWidget {
  const UserMatchListScreen({super.key});

  @override
  ConsumerState createState() => _UserMatchListScreenState();
}

class _UserMatchListScreenState extends ConsumerState<UserMatchListScreen>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  late UserMatchListViewNotifier notifier;
  bool _wantKeepAlive = true;

  @override
  bool get wantKeepAlive => _wantKeepAlive;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    notifier = ref.read(userMatchListStateProvider.notifier);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      setState(() {
        _wantKeepAlive = false;
      });
    } else if (state == AppLifecycleState.resumed) {
      setState(() {
        _wantKeepAlive = true;
      });
    } else if (state == AppLifecycleState.detached) {
      // deallocate resources
      notifier.dispose();
      WidgetsBinding.instance.removeObserver(this);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Builder(builder: (context) {
      return _body(context);
    });
  }

  Widget _body(BuildContext context) {
    final state = ref.watch(userMatchListStateProvider);
    if (state.loading) {
      return const AppProgressIndicator();
    }

    if (state.error != null) {
      return ErrorScreen(
        error: state.error,
        onRetryTap: notifier.onResume,
      );
    }

    if (state.matches.isNotEmpty) {
      return ListView.separated(
        padding: const EdgeInsets.all(16) + context.mediaQueryPadding,
        itemCount: state.matches.length,
        itemBuilder: (context, index) =>
            _matchListCell(context, state.matches.elementAt(index)),
        separatorBuilder: (context, index) => const SizedBox(height: 16),
      );
    } else {
      return Center(
        child: Text(
          context.l10n.match_list_no_match_yet_title,
          style: AppTextStyle.subtitle1
              .copyWith(color: context.colorScheme.textPrimary),
        ),
      );
    }
  }

  Widget _matchListCell(BuildContext context, MatchModel match) {
    return OnTapScale(
      onTap: () {
        AppRoute.matchDetailTab(matchId: match.id ?? "INVALID ID")
            .push(context);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: context.colorScheme.secondary),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _matchTimeAndGroundView(match),
            const SizedBox(height: 16),
            ...match.teams.map(
              (e) => _teamView(context, e),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Divider(
                color: context.colorScheme.outline,
                height: 1,
              ),
            ),
            _winnerMessageText(context, match)
          ],
        ),
      ),
    );
  }

  Widget _matchTimeAndGroundView(MatchModel match) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Flexible(
        flex: 2,
        child: Text(
            match.start_time.format(context, DateFormatType.dateAndTime),
            style: AppTextStyle.body2
                .copyWith(color: context.colorScheme.textPrimary)),
      ),
      Flexible(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset(
              Assets.images.icLocation,
              height: 20,
              width: 20,
              colorFilter: ColorFilter.mode(
                context.colorScheme.textSecondary,
                BlendMode.srcATop,
              ),
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                match.ground,
                style: AppTextStyle.body2
                    .copyWith(color: context.colorScheme.textPrimary),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  Widget _teamView(BuildContext context, MatchTeamModel match) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          ImageAvatar(
            initial: match.team.name[0].toUpperCase(),
            imageUrl: match.team.profile_img_url,
            size: 32,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(match.team.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: AppTextStyle.subtitle1
                    .copyWith(color: context.colorScheme.textPrimary)),
          ),
          Text.rich(TextSpan(
              text: "${match.run}-${match.wicket}",
              style: AppTextStyle.subtitle2
                  .copyWith(color: context.colorScheme.textPrimary),
              children: [
                TextSpan(
                  text: " ${match.over}",
                  style: AppTextStyle.body2
                      .copyWith(color: context.colorScheme.textSecondary),
                )
              ]))
        ],
      ),
    );
  }

  Widget _winnerMessageText(BuildContext context, MatchModel match) {
    final winSummary = match.getWinnerSummary(context);
    if (match.match_status == MatchStatus.finish && winSummary != null) {
      if (winSummary.teamName.isEmpty) {
        return Text(
          context.l10n.score_board_match_tied_text,
          style: AppTextStyle.subtitle1
              .copyWith(color: context.colorScheme.textPrimary),
        );
      }
      return WonByMessageText(
        teamName: winSummary.teamName,
        difference: winSummary.difference,
        trailingText: winSummary.wonByText,
      );
    } else {
      return const SizedBox();
    }
  }
}
