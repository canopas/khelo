import 'dart:io';

import 'package:data/service/device/device_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/gen/assets.gen.dart';
import 'package:khelo/ui/flow/app_links/app_links_handler.dart';
import 'package:khelo/ui/flow/my_game/my_game_tab_screen.dart';
import 'package:khelo/ui/flow/profile/profile_screen.dart';
import 'package:khelo/ui/flow/stats/user_stat/user_stat_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/navigation/bottom_navigation_bar.dart';

import '../../../domain/extensions/widget_extension.dart';
import '../home/home_screen.dart';
import '../notification/notification_permission_bottom_sheet.dart';
import 'main_screen_state_notifier.dart';
import 'notification_handler.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen>
    with WidgetsBindingObserver {
  final _materialPageController = PageController();
  final _cupertinoTabController = CupertinoTabController();
  void Function(int) onTabChange = (_) {};
  late final NotificationHandler notificationHandler;
  late final AppLinksHandler _appLinksHandler;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _appLinksHandler = AppLinksHandler();
    notificationHandler = ref.read(notificationHandlerProvider);
    runPostFrame(() {
      notificationHandler.init(context);
      _appLinksHandler.init(context);
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      // deallocate resources
      _materialPageController.dispose();
      _cupertinoTabController.dispose();
      WidgetsBinding.instance.removeObserver(this);
    }
  }

  @override
  void dispose() {
    _appLinksHandler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _observerShowNotificationPermissionPrompt(context);
    final List<Widget> widgets = <Widget>[
      const HomeScreen(),
      const MyGameTabScreen(),
      const UserStatScreen(),
      ProfileScreen(changeTabToMyCricket: () {
        changeTab(1);
      }),
    ];

    if (Platform.isIOS) {
      return _cupertinoTabs(context, widgets);
    }
    return _materialTabs(context, widgets);
  }

  void _observerShowNotificationPermissionPrompt(BuildContext context) {
    ref.listen(
        mainScreenStateNotifierProvider
            .select((value) => value.showNotificationPermissionPrompt),
        (previous, next) async {
      if (next != null) {
        final isNotificationPermissionRequired =
            await DeviceService.isNotificationPermissionRequired();
        final bool hasPermission =
            await Permission.notification.status.isGranted;
        if (context.mounted &&
            isNotificationPermissionRequired &&
            !hasPermission) {
          ref
              .read(mainScreenStateNotifierProvider.notifier)
              .notificationPermissionPromptShown();
          await showPermissionBottomSheet(context);
        }
      }
    });
  }

  Widget _cupertinoTabs(BuildContext context, List<Widget> widgets) =>
      CupertinoTabScaffold(
        backgroundColor: context.colorScheme.surface,
        controller: _cupertinoTabController,
        tabBar: CupertinoTabBar(
          backgroundColor: context.colorScheme.surface,
          height: 65,
          border: Border(
            top: BorderSide(
              color: context.colorScheme.outline,
              width: 1,
            ),
          ),
          items: _tabItems(context)
              .map((e) => e.toBottomNavigationBarItem(context))
              .toList(),
        ),
        tabBuilder: (BuildContext context, int index) {
          return CupertinoTabView(
            builder: (BuildContext context) => widgets[index],
          );
        },
      );

  Widget _materialTabs(BuildContext context, List<Widget> widgets) => Scaffold(
        backgroundColor: context.colorScheme.surface,
        body: PageView(
          controller: _materialPageController,
          physics: const NeverScrollableScrollPhysics(),
          children: widgets,
        ),
        bottomNavigationBar: AppBottomNavigationBar(
          tabs: _tabItems(context),
          builder: (BuildContext context, void Function(int) onTabTap) {
            onTabChange = onTabTap;
          },
        ),
      );

  List<TabItem> _tabItems(BuildContext context) => [
        TabItem(
          tabIcon: _tabImage(context, imagePath: Assets.images.icHome),
          tabActiveIcon: _tabImage(context,
              imagePath: Assets.images.icHome, isActive: true),
          tabLabel: context.l10n.home_screen_title,
          route: '',
          onTap: () => _materialPageController.jumpToPage(0),
        ),
        TabItem(
          tabIcon: _tabImage(context, imagePath: Assets.images.icCricket),
          tabActiveIcon: _tabImage(
            context,
            imagePath: Assets.images.icCricket,
            isActive: true,
          ),
          tabLabel: context.l10n.my_cricket_screen_title,
          route: '',
          onTap: () => _materialPageController.jumpToPage(1),
        ),
        TabItem(
          tabIcon: _tabImage(context, imagePath: Assets.images.icStats),
          tabActiveIcon: _tabImage(context,
              imagePath: Assets.images.icStats, isActive: true),
          tabLabel: context.l10n.common_stats_title,
          route: '',
          onTap: () => _materialPageController.jumpToPage(2),
        ),
        TabItem(
          tabIcon: _tabImage(context, imagePath: Assets.images.icProfile),
          tabActiveIcon: _tabImage(context,
              imagePath: Assets.images.icProfile, isActive: true),
          tabLabel: context.l10n.tab_profile_title,
          route: '',
          onTap: () => _materialPageController.jumpToPage(3),
        ),
      ];

  Widget _tabImage(
    BuildContext context, {
    required String imagePath,
    bool isActive = false,
  }) {
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      decoration: BoxDecoration(
          color: isActive ? context.colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(30)),
      child: SvgPicture.asset(imagePath,
          height: 24,
          width: 24,
          colorFilter: ColorFilter.mode(
              isActive
                  ? context.colorScheme.onPrimary
                  : context.colorScheme.textDisabled,
              BlendMode.srcIn)),
    );
  }

  void changeTab(int tabNumber) {
    if (Platform.isIOS) {
      _cupertinoTabController.index = tabNumber;
    } else {
      _materialPageController.jumpToPage(tabNumber);
      onTabChange.call(tabNumber);
    }
  }
}
