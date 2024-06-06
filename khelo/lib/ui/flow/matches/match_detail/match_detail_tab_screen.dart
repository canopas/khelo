import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/string_extensions.dart';
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
  final ScrollController _scrollController = ScrollController();

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

  final List<GlobalKey> _keys = List.generate(50, (index) => GlobalKey());

  void _scrollToIndex(int index) {
    _scrollController.position.ensureVisible(
        _keys[index].currentContext!.findRenderObject() as RenderBox,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(matchDetailTabStateProvider);

    return AppPage(
      title: _getScreenTitle(context, state),
      body: Builder(
        builder: (context) {
          return _content(context, notifier);
        },
      ),
    );
  }

  String _getScreenTitle(BuildContext context, MatchDetailTabState state) {
    if (state.match != null) {
      String title = state.match!.teams
          .map((e) => e.team.name.initials(limit: 3))
          .join(" ${context.l10n.add_match_versus_short_title} ");
      return title;
    }
    return "${context.l10n.add_match_team_a_title} ${context.l10n.add_match_versus_short_title} ${context.l10n.add_match_team_b_title}";
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
                _scrollToIndex(index);
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
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
      child: Row(
          children: MatchDetailTab.values
              .map(
                (tab) => _tabButton(
                  tab.getString(context),
                  _selectedTab == tab.index,
                  tab.index,
                  onTap: () {
                    _controller.jumpToPage(tab.index);
                  },
                ),
              )
              .toList()),
    );
  }

  Widget _tabButton(String title, bool selected, int index,
      {VoidCallback? onTap}) {
    return OnTapScale(
      onTap: onTap,
      child: Container(
        key: _keys[index],
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
