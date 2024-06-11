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
import 'package:style/button/action_button.dart';
import 'package:style/button/large_icon_button.dart';
import 'package:style/button/tab_button.dart';
import 'package:style/extensions/context_extensions.dart';

class MyGameTabScreen extends ConsumerStatefulWidget {
  const MyGameTabScreen({super.key});

  @override
  ConsumerState createState() => _MyGameTabScreenState();
}

class _MyGameTabScreenState extends ConsumerState<MyGameTabScreen>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  final List<Widget> _tabs = [
    const MatchListScreen(),
    const TeamListScreen(),
  ];

  late PageController _controller;

  int get _selectedTab => _controller.hasClients
      ? _controller.page?.round() ?? 0
      : _controller.initialPage;
  bool _wantKeepAlive = true;

  @override
  bool get wantKeepAlive => _wantKeepAlive;

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
      _controller.dispose();
      WidgetsBinding.instance.removeObserver(this);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final notifier = ref.watch(myGameTabViewStateProvider.notifier);

    return AppPage(
      floatingActionButton: Visibility(
        visible: _selectedTab == 0,
        child: _floatingAddButton(context),
      ),
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
            onTap: () {
              _controller.jumpToPage(0);
            },
          ),
          const SizedBox(width: 8),
          TabButton(
            context.l10n.my_game_teams_tab_title,
            selected: _selectedTab == 1,
            onTap: () {
              _controller.jumpToPage(1);
            },
          ),
          if (_selectedTab == 1) ...[
            const Spacer(),
            actionButton(context,
                onPressed: () => ref
                    .read(teamListViewStateProvider.notifier)
                    .onFilterButtonTap(),
                icon: Icon(CupertinoIcons.slider_horizontal_3,
                    color: context.colorScheme.primary)),
            actionButton(context,
                onPressed: () => AppRoute.addTeam().push(context),
                icon: Icon(Icons.add, color: context.colorScheme.primary)),
          ]
        ],
      ),
    );
  }

  Widget _floatingAddButton(
    BuildContext context,
  ) {
    return LargeIconButton(
      backgroundColor: context.colorScheme.primary,
      onTap: () async {
        // AppRoute.addMatch().push(context);
        // FirebaseCrashlytics.instance.crash();
      },
      icon: Icon(
        Icons.add_rounded,
        color: context.colorScheme.onPrimary,
      ),
    );
  }
}
