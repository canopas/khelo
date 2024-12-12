import 'package:collection/collection.dart';
import 'package:data/api/leaderboard/leaderboard_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/ui/flow/leaderboard/leaderboard_view_model.dart';
import 'package:style/button/tab_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';

import '../../../components/empty_screen.dart';
import '../../../components/error_screen.dart';
import '../../../domain/extensions/widget_extension.dart';

class LeaderboardScreen extends ConsumerStatefulWidget {
  final LeaderboardField selectedField;

  const LeaderboardScreen({
    super.key,
    required this.selectedField,
  });

  @override
  ConsumerState createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends ConsumerState<LeaderboardScreen> {
  late PageController _controller;
  late LeaderboardViewNotifier notifier;

  int get _selectedTab => _controller.hasClients
      ? _controller.page?.round() ?? 0
      : _controller.initialPage;

  @override
  void initState() {
    super.initState();
    notifier = ref.read(leaderboardStateProvider.notifier);

    runPostFrame(() => notifier.onTabChange(widget.selectedField.index));
    _controller = PageController(
      initialPage: widget.selectedField.index,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(leaderboardStateProvider);

    return AppPage(
      title: context.l10n.common_leaderboard,
      body: Builder(
        builder: (context) => _body(context, state),
      ),
    );
  }

  Widget _body(BuildContext context, LeaderboardViewState state) {
    if (state.loading) {
      return const Center(child: AppProgressIndicator());
    } else if (state.error != null) {
      return ErrorScreen(
        error: state.error,
        onRetryTap: notifier.loadLeaderboard,
      );
    } else if (state.leaderboard.isEmpty) {
      return _emptyLeaderboard(context);
    }

    return Padding(
      padding: context.mediaQueryPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _tabView(context),
          _content(context, state),
        ],
      ),
    );
  }

  Widget _emptyLeaderboard(BuildContext context) {
    return EmptyScreen(
      title: context.l10n.leaderboard_empty_title,
      description: context.l10n.leaderboard_empty_description,
      isShowButton: false,
    );
  }

  Widget _tabView(BuildContext context) {
    final tabs = LeaderboardField.values;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(
          tabs.length,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: TabButton(
              tabs[index].getString(context),
              onTap: () => _controller.jumpToPage(index),
              selected: index == _selectedTab,
            ),
          ),
        ),
      ),
    );
  }

  Widget _content(BuildContext context, LeaderboardViewState state) {
    return Expanded(
      child: PageView(
        controller: _controller,
        onPageChanged: notifier.onTabChange,
        children: LeaderboardField.values
            .map((field) => _playerListView(context, state, field))
            .toList(),
      ),
    );
  }

  Widget _playerListView(BuildContext context, LeaderboardViewState state,
      LeaderboardField field) {
    final players = state.leaderboard
            .firstWhereOrNull((data) => data.type == field)
            ?.players ??
        [];

    if (players.isEmpty) {
      return _emptyLeaderboard(context);
    }
    return ListView.separated(
      padding: EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final player = players[index];
        return _leaderboardCell(
          player: player,
          field: field,
          rank: index + 1,
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 16),
      itemCount: players.length,
    );
  }

  Widget _leaderboardCell({
    required LeaderboardPlayer player,
    required LeaderboardField field,
    required int rank,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.colorScheme.outline),
      ),
      child: Row(
        children: [
          Text(
            rank.toString().padLeft(2, '0'),
            style: AppTextStyle.subtitle2
                .copyWith(color: context.colorScheme.textPrimary),
          ),
          SizedBox(width: 16),
          ImageAvatar(
            initial: player.user?.nameInitial ?? "?",
            imageUrl: player.user?.profile_img_url,
            size: 42,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              player.user?.name ?? "Deactivated User",
              style: AppTextStyle.subtitle2
                  .copyWith(color: context.colorScheme.textPrimary),
            ),
          ),
          SizedBox(width: 8),
          Material(
            type: MaterialType.transparency,
            child: Chip(
              label: Text(
                _getCountAsPerField(context, player, field),
                style: AppTextStyle.body2.copyWith(
                  color: rank <= 2
                      ? context.colorScheme.onPrimary
                      : context.colorScheme.primary,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              side: const BorderSide(color: Colors.transparent),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              backgroundColor: rank <= 2
                  ? context.colorScheme.primary
                  : context.colorScheme.containerLowOnSurface,
            ),
          ),
        ],
      ),
    );
  }

  String _getCountAsPerField(
      BuildContext context, LeaderboardPlayer player, LeaderboardField field) {
    switch (field) {
      case LeaderboardField.batting:
        return context.l10n.common_runs_title(player.runs);
      case LeaderboardField.bowling:
        return context.l10n.common_wickets_title(player.wickets);
      case LeaderboardField.fielding:
        return context.l10n.leaderboard_catches_title(player.catches);
    }
  }
}
