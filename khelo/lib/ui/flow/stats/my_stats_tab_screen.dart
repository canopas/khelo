import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/stats/my_stats_tab_view_model.dart';
import 'package:khelo/ui/flow/stats/user_match/user_match_list_screen.dart';
import 'package:khelo/ui/flow/stats/user_stat/user_stat_screen.dart';
import 'package:style/button/action_button.dart';
import 'package:style/button/tab_button.dart';
import 'package:style/extensions/context_extensions.dart';

class MyStatsTabScreen extends ConsumerStatefulWidget {
  const MyStatsTabScreen({super.key});

  @override
  ConsumerState createState() => _MyStatsTabScreenState();
}

class _MyStatsTabScreenState extends ConsumerState<MyStatsTabScreen>
    with WidgetsBindingObserver {
  final List<Widget> _tabs = [
    const UserMatchListScreen(),
    const UserStatScreen(),
  ];

  late PageController _controller;

  int get _selectedTab => _controller.hasClients
      ? _controller.page?.round() ?? 0
      : _controller.initialPage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _controller = PageController(
      initialPage: ref.read(myStatsTabStateProvider).selectedTab,
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      // deallocate resources
      _controller.dispose();
      WidgetsBinding.instance.removeObserver(this);
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(myStatsTabStateProvider.notifier);
    return AppPage(
      body: Builder(
        builder: (context) {
          return _content(context, notifier);
        },
      ),
    );
  }

  Widget _content(BuildContext context, MyStatsTabViewNotifier notifier) {
    return SafeArea(
      child: Column(
        children: [
          _tabView(context),
          Expanded(
            child: PageView(
              controller: _controller,
              children: _tabs,
              onPageChanged: (index) {
                notifier.onTabChange(index);
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          TabButton(
            context.l10n.common_matches_title,
            selected: _selectedTab == 0,
            onTap: () => _controller.jumpToPage(0),
          ),
          const SizedBox(width: 8),
          TabButton(
            context.l10n.tab_stats_title,
            selected: _selectedTab == 1,
            onTap: () => _controller.jumpToPage(1),
          ),

          // Dummy add-icon to maintain consistency in tab placement for myCricket & Stats tab.
          Visibility(
            visible: false,
            maintainState: true,
            maintainAnimation: true,
            maintainSize: true,
            child: actionButton(context,
                onPressed: null,
                icon: Icon(Icons.add, color: context.colorScheme.primary)),
          ),
        ],
      ),
    );
  }
}
