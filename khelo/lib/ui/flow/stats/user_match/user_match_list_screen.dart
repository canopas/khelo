import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/error_screen.dart';
import 'package:khelo/components/match_detail_cell.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/stats/user_match/user_match_list_view_model.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';

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

    if (state.matches.isNotEmpty) {
      return ListView.separated(
        padding: const EdgeInsets.all(16) + context.mediaQueryPadding,
        itemCount: state.matches.length,
        itemBuilder: (context, index) => MatchDetailCell(
          match: state.matches.elementAt(index),
          showStatusTag: false,
          onTap: () => AppRoute.matchDetailTab(
                  matchId: state.matches.elementAt(index).id ?? "INVALID ID")
              .push(context),
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 16),
      );
    } else {
      return Center(
        child: Text(
          context.l10n.match_list_no_match_yet_title,
          style: AppTextStyle.body1
              .copyWith(color: context.colorScheme.textPrimary),
        ),
      );
    }
  }
}
