import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/my_game/my_game_tab_screen.dart';
import 'package:khelo/ui/flow/profile/profile_screen.dart';
import 'package:khelo/ui/flow/stats/my_stats_tab_screen.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/navigation/bottom_navigation_bar.dart';

import '../home/home_screen.dart';

class MainScreen extends ConsumerStatefulWidget {
  final String? communityShareId;

  const MainScreen({super.key, this.communityShareId});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  static final List<Widget> _widgets = <Widget>[
    const HomeScreen(),
    const MyGameTabScreen(),
    const MyStatsTabScreen(),
    const ProfileScreen(),
  ];

  final _materialPageController = PageController();
  final _cupertinoTabController = CupertinoTabController();

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return _cupertinoTabs(context);
    }
    return _materialTabs(context);
  }

  Widget _cupertinoTabs(BuildContext context) => CupertinoTabScaffold(
        backgroundColor: context.colorScheme.surface,
        controller: _cupertinoTabController,
        tabBar: CupertinoTabBar(
          backgroundColor: context.colorScheme.containerNormalOnSurface,
          items: _tabItems(context)
              .map((e) => e.toBottomNavigationBarItem(context))
              .toList(),
        ),
        tabBuilder: (BuildContext context, int index) {
          return CupertinoTabView(
            builder: (BuildContext context) {
              return _widgets[index];
            },
          );
        },
      );

  Widget _materialTabs(BuildContext context) => Scaffold(
        backgroundColor: context.colorScheme.surface,
        body: PageView(
          controller: _materialPageController,
          physics: const NeverScrollableScrollPhysics(),
          children: _widgets,
        ),
        bottomNavigationBar: AppBottomNavigationBar(tabs: _tabItems(context)),
      );

  List<TabItem> _tabItems(BuildContext context) => [
        TabItem(
          tabIcon: const Icon(Icons.home_outlined),
          tabActiveIcon: const Icon(Icons.home),
          tabLabel: context.l10n.tab_home_title,
          route: '',
          onTap: () {
            _materialPageController.jumpToPage(0);
          },
        ),
        TabItem(
          tabIcon: const Icon(Icons.sports_baseball_outlined),
          tabActiveIcon: const Icon(Icons.sports_baseball),
          tabLabel: context.l10n.tab_my_cricket_title,
          route: '',
          onTap: () {
            _materialPageController.jumpToPage(1);
          },
        ),
        TabItem(
          tabIcon: const Icon(Icons.stacked_bar_chart_outlined),
          tabActiveIcon: const Icon(Icons.stacked_bar_chart),
          tabLabel: context.l10n.tab_stats_title,
          route: '',
          onTap: () {
            _materialPageController.jumpToPage(2);
          },
        ),
        TabItem(
          tabIcon: const Icon(Icons.person_outlined),
          tabActiveIcon: const Icon(Icons.person),
          tabLabel: context.l10n.tab_profile_title,
          route: '',
          onTap: () {
            _materialPageController.jumpToPage(3);
          },
        ),
      ];
}
