import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/domain/extensions/widget_extension.dart';
import 'package:khelo/ui/flow/matches/match_detail/match_detail_tab_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class MatchDetailTabScreen extends ConsumerStatefulWidget {
  final String matchId;

  const MatchDetailTabScreen({super.key, required this.matchId});

  @override
  ConsumerState createState() => _MatchDetailTabScreenState();
}

class _MatchDetailTabScreenState extends ConsumerState<MatchDetailTabScreen> {
  late MatchDetailTabViewNotifier notifier;
  late PageController _controller;

  int get _selectedTab => _controller.hasClients
      ? _controller.page?.round() ?? 0
      : _controller.initialPage;

  @override
  void initState() {
    super.initState();
    notifier = ref.read(matchDetailTabStateProvider.notifier);
    runPostFrame(() => notifier.setData(widget.matchId));
    _controller = PageController(
      initialPage: ref.read(matchDetailTabStateProvider).selectedTab,
    );
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(matchDetailTabStateProvider.notifier);

    return AppPage(
      title: "this Vs this",
      body: Builder(
        builder: (context) {
          return _content(context, notifier);
        },
      ),
    );
  }

  Widget _content(BuildContext context, MatchDetailTabViewNotifier notifier) {
    return SafeArea(
      child: Column(
        children: [
          _tabView(context),
          Expanded(
            child: PageView(
              controller: _controller,
              children: MatchDetailTab.values
                  .map((tab) => tab.getTabScreen())
                  .toList(),
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
      child: Row(
          children: MatchDetailTab.values
              .map(
                (tab) => _tabButton(
                  tab.getString(context),
                  _selectedTab == tab.index,
                  onTap: () {
                    _controller.jumpToPage(tab.index);
                  },
                ),
              )
              .toList()),
    );
  }

  Widget _tabButton(String title, bool selected, {VoidCallback? onTap}) {
    return OnTapScale(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.only(right: 16),
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
                : context.colorScheme.textDisabled,
          ),
        ),
      ),
    );
  }
}
