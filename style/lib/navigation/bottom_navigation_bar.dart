import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';
import '../text/app_text_style.dart';

typedef TabTapMethodBuilder = void Function(
    BuildContext context, void Function(int) onTabTap);

class TabItem {
  final Widget tabIcon;
  final Widget tabActiveIcon;
  final String tabLabel;
  final String route;
  final Function onTap;

  const TabItem({
    required this.tabIcon,
    required this.tabActiveIcon,
    required this.tabLabel,
    required this.route,
    required this.onTap,
  });

  BottomNavigationBarItem toBottomNavigationBarItem(BuildContext context) {
    return BottomNavigationBarItem(
      icon: tabIcon,
      label: tabLabel,
      activeIcon: tabActiveIcon,
    );
  }
}

class AppBottomNavigationBar extends StatefulWidget {
  final TabTapMethodBuilder builder;

  final List<TabItem> tabs;

  const AppBottomNavigationBar({
    super.key,
    required this.tabs,
    required this.builder,
  });

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  int _selectedIndex = 0;

  void onTab(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    widget.builder.call(context, onTab);
    final colors = context.colorScheme;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: context.colorScheme.outline,
            width: 1,
          ),
        ),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        unselectedItemColor: colors.textDisabled,
        selectedItemColor: colors.primary,
        backgroundColor: colors.surface,
        selectedLabelStyle:
            AppTextStyle.caption.copyWith(color: colors.primary),
        unselectedLabelStyle:
            AppTextStyle.caption.copyWith(color: colors.textDisabled),
        onTap: (index) {
          onTab(index);
          widget.tabs[index].onTap.call();
        },
        items: List.generate(
          widget.tabs.length,
          (index) => widget.tabs[index].toBottomNavigationBarItem(context),
        ),
      ),
    );
  }
}
