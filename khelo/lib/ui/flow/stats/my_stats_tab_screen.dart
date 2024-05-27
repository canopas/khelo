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

class _MyStatsTabScreenState extends ConsumerState<MyStatsTabScreen>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  final List<Widget> _tabs = [
    const UserMatchListScreen(),
    const UserStatScreen(),
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
      initialPage: ref.read(myStatsTabStateProvider).selectedTab,
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
    final notifier = ref.watch(myStatsTabStateProvider.notifier);
    super.build(context);
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
