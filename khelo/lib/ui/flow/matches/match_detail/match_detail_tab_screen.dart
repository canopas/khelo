import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/string_extensions.dart';
import 'package:khelo/domain/extensions/widget_extension.dart';
import 'package:khelo/main.dart';
import 'package:khelo/ui/flow/matches/match_detail/match_detail_tab_view_model.dart';
import 'package:share_plus/share_plus.dart';
import 'package:style/button/action_button.dart';
import 'package:style/button/tab_button.dart';
import 'package:style/extensions/context_extensions.dart';

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
      actions: [
        actionButton(
          context,
          icon: Icon(
            Platform.isIOS ? Icons.share : Icons.share_outlined,
            size: 20,
            color: context.colorScheme.textPrimary,
          ),
          onPressed: () =>
              Share.shareUri(Uri.parse("$appBaseUrl/match/${widget.matchId}")),
        )
      ],
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
          .map((e) => e.team.name_initial ?? e.team.name.initials(limit: 3))
          .join(" ${context.l10n.common_versus_short_title} ");
      return title;
    }
    return "${context.l10n.common_a_title} ${context.l10n.common_versus_short_title} ${context.l10n.add_match_team_b_title}";
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
      padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
      child: Row(
          children: MatchDetailTab.values
              .map(
                (tab) => Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: TabButton(
                    tab.getString(context),
                    selected: _selectedTab == tab.index,
                    globalKey: _keys[tab.index],
                    onTap: () {
                      _controller.jumpToPage(tab.index);
                    },
                  ),
                ),
              )
              .toList()),
    );
  }
}
