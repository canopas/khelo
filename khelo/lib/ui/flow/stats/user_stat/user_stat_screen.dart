import 'package:data/api/user/user_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/error_screen.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/stats/user_stat/user_stat_view_model.dart';
import 'package:khelo/ui/flow/team/user_detail/component/user_detail_fielding_content.dart';
import 'package:style/button/tab_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';

import '../../team/user_detail/component/user_detail_batting_content.dart';
import '../../team/user_detail/component/user_detail_bowling_content.dart';

class UserStatScreen extends ConsumerStatefulWidget {
  const UserStatScreen({super.key});

  @override
  ConsumerState createState() => _UserStatScreenState();
}

class _UserStatScreenState extends ConsumerState<UserStatScreen>
    with WidgetsBindingObserver {
  late PageController _controller;

  int get _selectedTab => _controller.hasClients
      ? _controller.page?.round() ?? 0
      : _controller.initialPage;

  late UserStatViewNotifier notifier;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    notifier = ref.read(userStatViewStateProvider.notifier);
    _controller = PageController(
      initialPage: ref.read(userStatViewStateProvider).selectedTab,
    );
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
    return AppPage(
      body: Builder(builder: (context) => _body(context)),
    );
  }

  Widget _body(BuildContext context) {
    final state = ref.watch(userStatViewStateProvider);
    if (state.loading) {
      return const Center(child: AppProgressIndicator());
    }
    if (state.error != null) {
      return ErrorScreen(
        error: state.error,
        onRetryTap: notifier.loadData,
      );
    }

    return Padding(
      padding: context.mediaQueryPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _tabView(context),
          _content(context, state),
        ],
      ),
    );
  }

  Widget _tabView(BuildContext context) {
    final tabs = [
      context.l10n.common_batting,
      context.l10n.common_bowling,
      context.l10n.common_fielding
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(
          tabs.length,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: TabButton(
              tabs[index],
              onTap: () {
                _controller.jumpToPage(index);
              },
              selected: index == _selectedTab,
            ),
          ),
        ),
      ),
    );
  }

  Widget _content(BuildContext context, UserStatViewState state) {
    final testStats = state.userStats
            ?.firstWhere((element) => element.type == UserStatType.test) ??
        UserStat();
    final otherStats = state.userStats
            ?.firstWhere((element) => element.type == UserStatType.other) ??
        UserStat();

    return Expanded(
      child: PageView(
        controller: _controller,
        onPageChanged: notifier.onTabChange,
        children: [
          UserDetailBattingContent(
            testMatchesCount: testStats.matches,
            otherMatchesCount: otherStats.matches,
            testStats: testStats.batting,
            otherStats: otherStats.batting,
          ),
          UserDetailBowlingContent(
            testMatchesCount: testStats.matches,
            otherMatchesCount: otherStats.matches,
            testStats: testStats.bowling,
            otherStats: otherStats.bowling,
          ),
          UserDetailFieldingContent(
            testMatchesCount: testStats.matches,
            otherMatchesCount: otherStats.matches,
            testStats: testStats.fielding,
            otherStats: otherStats.fielding,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
