import 'package:data/api/match/match_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/error_screen.dart';
import 'package:khelo/components/match_detail_cell.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/domain/formatter/date_formatter.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';

import 'match_list_view_model.dart';

class MatchListScreen extends ConsumerStatefulWidget {
  const MatchListScreen({super.key});

  @override
  ConsumerState createState() => _MatchListScreenState();
}

class _MatchListScreenState extends ConsumerState<MatchListScreen>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  late MatchListViewNotifier notifier;
  bool _wantKeepAlive = true;

  @override
  bool get wantKeepAlive => _wantKeepAlive;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
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
    final state = ref.watch(matchListStateProvider);
    notifier = ref.watch(matchListStateProvider.notifier);

    return _matchList(context, notifier, state);
  }

  Widget _matchList(
    BuildContext context,
    MatchListViewNotifier notifier,
    MatchListViewState state,
  ) {
    if (state.loading) {
      return const Center(
        child: AppProgressIndicator(),
      );
    }
    if (state.error != null) {
      return ErrorScreen(
        error: state.error,
        onRetryTap: notifier.onResume,
      );
    }

    if (state.matches != null && state.matches!.isNotEmpty) {
      return ListView.separated(
        padding: context.mediaQueryPadding +
            const EdgeInsets.all(16) +
            const EdgeInsets.only(bottom: 70),
        itemCount: state.matches!.length,
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16);
        },
        itemBuilder: (context, index) {
          final match = state.matches![index];
          return MatchDetailCell(
            match: match,
            showActionButtons: match.created_by == state.currentUserId,
            onTap: () =>
                AppRoute.matchDetailTab(matchId: match.id ?? "").push(context),
            onActionTap: () {
              if (match.match_status == MatchStatus.yetToStart) {
                AppRoute.addMatch(matchId: match.id).push(context);
              } else {
                if (match.toss_decision == null ||
                    match.toss_winner_id == null) {
                  AppRoute.addTossDetail(matchId: match.id ?? "INVALID_ID")
                      .push(context);
                } else {
                  AppRoute.scoreBoard(matchId: match.id ?? "INVALID_ID")
                      .push(context);
                }
              }
            },
          );
        },
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
}
