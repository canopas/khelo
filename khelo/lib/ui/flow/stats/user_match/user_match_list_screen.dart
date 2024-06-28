import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/empty_screen.dart';
import 'package:khelo/components/error_screen.dart';
import 'package:khelo/components/match_detail_cell.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/app_route.dart';

import 'package:khelo/ui/flow/stats/user_match/user_match_list_view_model.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';

class UserMatchListScreen extends ConsumerStatefulWidget {
  const UserMatchListScreen({super.key});

  @override
  ConsumerState createState() => _UserMatchListScreenState();
}

class _UserMatchListScreenState extends ConsumerState<UserMatchListScreen>
    with WidgetsBindingObserver {
  late UserMatchListViewNotifier notifier;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    notifier = ref.read(userMatchListStateProvider.notifier);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      // deallocate resources
      notifier.dispose();
      WidgetsBinding.instance.removeObserver(this);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return _body(context);
    });
  }

  Widget _body(BuildContext context) {
    final state = ref.watch(userMatchListStateProvider);
    if (state.loading) {
      return const Center(child: AppProgressIndicator());
    }

    if (state.error != null) {
      return ErrorScreen(
        error: state.error,
        onRetryTap: notifier.onResume,
      );
    }

    return (state.matches.isNotEmpty)
        ? ListView.separated(
            padding: const EdgeInsets.all(16) + context.mediaQueryPadding,
            itemCount: state.matches.length,
            itemBuilder: (context, index) => MatchDetailCell(
              match: state.matches.elementAt(index),
              showStatusTag: false,
              onTap: () => AppRoute.matchDetailTab(
                      matchId:
                          state.matches.elementAt(index).id ?? "INVALID ID")
                  .push(context),
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 16),
          )
        : EmptyScreen(
            title: context.l10n.team_detail_empty_matches_title,
            description:
                context.l10n.team_detail_empty_matches_description_text,
            buttonTitle: context.l10n.add_match_screen_title,
            onTap: () => AppRoute.addMatch().push(context),
          );
  }
}
