import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/matches/match_list_screen.dart';
import 'package:khelo/ui/flow/my_game/my_game_tab_view_model.dart';
import 'package:khelo/ui/flow/team/team_list_screen.dart';
import 'package:khelo/ui/flow/team/team_list_view_model.dart';
import 'package:khelo/ui/flow/tournament/tournament_list_screen.dart';
import 'package:style/button/action_button.dart';
import 'package:style/button/tab_button.dart';
import 'package:style/extensions/context_extensions.dart';

class MyGameTabScreen extends ConsumerStatefulWidget {
  const MyGameTabScreen({super.key});

  @override
  ConsumerState createState() => _MyGameTabScreenState();
}

class _MyGameTabScreenState extends ConsumerState<MyGameTabScreen>
    with WidgetsBindingObserver {
  final List<Widget> _tabs = [
    const MatchListScreen(),
    const TeamListScreen(),
    const TournamentListScreen(),
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
      initialPage: ref.read(myGameTabViewStateProvider).selectedTab,
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
    final notifier = ref.watch(myGameTabViewStateProvider.notifier);

    return AppPage(
      body: Builder(
        builder: (context) {
          return _content(context, notifier);
        },
      ),
    );
  }

  Widget _content(BuildContext context, MyGameTabViewNotifier notifier) {
    return SafeArea(
      child: Column(
        children: [
          _tabView(context),
          Expanded(
            child: PageView(
              controller: _controller,
              onPageChanged: (tab) {
                notifier.onTabChange(tab);
                setState(() {});
              },
              children: _tabs,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 36,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  const SizedBox(width: 16),
                  TabButton(
                    context.l10n.common_matches_title,
                    selected: _selectedTab == 0,
                    onTap: () {
                      _controller.jumpToPage(0);
                    },
                  ),
                  const SizedBox(width: 8),
                  TabButton(
                    context.l10n.common_teams_title,
                    selected: _selectedTab == 1,
                    onTap: () {
                      _controller.jumpToPage(1);
                    },
                  ),
                  const SizedBox(width: 8),
                  TabButton(
                    context.l10n.common_tournaments,
                    selected: _selectedTab == 2,
                    onTap: () {
                      _controller.jumpToPage(2);
                    },
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),
          ),
          Container(
            color: context.colorScheme.surface,
            child: Row(
              children: [
                if (_selectedTab == 1 &&
                    ref.watch(teamListViewStateProvider).teams.isNotEmpty) ...[
                  actionButton(
                    context,
                    onPressed: () => ref
                        .read(teamListViewStateProvider.notifier)
                        .onFilterButtonTap(),
                    icon: Icon(
                      CupertinoIcons.slider_horizontal_3,
                      color: context.colorScheme.textPrimary,
                    ),
                  ),
                ],
                actionButton(
                  context,
                  onPressed: () {
                    final actions = [
                      AppRoute.addMatch(),
                      AppRoute.addTeam(),
                      AppRoute.addTournament(),
                    ];
                    actions[_selectedTab].push(context);
                  },
                  icon: Icon(
                    Icons.add,
                    color: context.colorScheme.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
