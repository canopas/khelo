import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/stats/my_stats_tab_view_model.dart';
import 'package:khelo/ui/flow/stats/user_match/user_match_list_screen.dart';
import 'package:khelo/ui/flow/stats/user_stat/user_stat_screen.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class MyStatsTabScreen extends ConsumerStatefulWidget {
  const MyStatsTabScreen({super.key});

  @override
  ConsumerState createState() => _MyStatsTabScreenState();
}

class _MyStatsTabScreenState extends ConsumerState<MyStatsTabScreen> {
  final List<Widget> _tabs = [
    const UserMatchListScreen(),
    const UserStatScreen(),
  ];

  late PageController _controller;
  late MyStatsTabViewNotifier notifier;

  int get _selectedTab => _controller.hasClients
      ? _controller.page?.round() ?? 0
      : _controller.initialPage;

  @override
  void initState() {
    super.initState();
    notifier = ref.read(myStatsTabStateProvider.notifier);
    _controller = PageController(
      initialPage: ref.read(myStatsTabStateProvider).initialTab,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      body: Builder(
        builder: (context) {
          return _content(context);
        },
      ),
    );
  }

  Widget _content(BuildContext context) {
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
          _tabButton(
            context.l10n.my_stat_matches_tab_title,
            _selectedTab == 0,
            onTap: () {
              _controller.jumpToPage(0);
            },
          ),
          const SizedBox(width: 8),
          _tabButton(
            context.l10n.my_stat_stats_tab_title,
            _selectedTab == 1,
            onTap: () {
              _controller.jumpToPage(1);
            },
          ),
        ],
      ),
    );
  }

  Widget _tabButton(String title, bool selected, {VoidCallback? onTap}) {
    return OnTapScale(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? context.colorScheme.primary
              : context.colorScheme.containerLow,
          borderRadius: BorderRadius.circular(56),
        ),
        child: Text(
          title,
          style: AppTextStyle.body2.copyWith(
            color: selected
                ? context.colorScheme.onPrimary
                : context.colorScheme.textSecondary,
          ),
        ),
      ),
    );
  }
}
