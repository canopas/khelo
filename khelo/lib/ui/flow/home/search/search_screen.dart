import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/empty_screen.dart';
import 'package:khelo/components/match_detail_cell.dart';
import 'package:khelo/components/team_detail_cell.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/widget_extension.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/home/search/search_view_model.dart';
import 'package:style/button/action_button.dart';
import 'package:style/button/tab_button.dart';
import 'package:style/callback/on_visible_callback.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/search_text_field.dart';

import '../../../../components/user_detail_cell.dart';
import '../components/tournament_item.dart';

class SearchHomeScreen extends ConsumerStatefulWidget {
  const SearchHomeScreen({super.key});

  @override
  ConsumerState<SearchHomeScreen> createState() => _SearchHomeScreenState();
}

class _SearchHomeScreenState extends ConsumerState<SearchHomeScreen> {
  late SearchHomeViewNotifier notifier;
  late PageController _controller;

  int get _selectedTab => _controller.hasClients
      ? _controller.page?.round() ?? 0
      : _controller.initialPage;

  @override
  void initState() {
    super.initState();
    notifier = ref.read(searchHomeViewProvider.notifier);
    _controller = PageController(
      initialPage: ref.read(searchHomeViewProvider).selectedTab,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchHomeViewProvider);
    return AppPage(
      automaticallyImplyLeading: false,
      body: Padding(
        padding: context.mediaQueryPadding + const EdgeInsets.only(top: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _searchBarField(context, state),
            Divider(
              color: context.colorScheme.outline,
              height: 24,
              thickness: 1,
            ),
            _tabView(context),
            _content(context, state),
          ],
        ),
      ),
    );
  }

  Widget _emptyScreen(BuildContext context, {required bool isSearchEmpty}) {
    return EmptyScreen(
      title: (isSearchEmpty)
          ? context.l10n.home_search_empty_title
          : context.l10n.home_search_list_empty_title,
      description: (isSearchEmpty)
          ? context.l10n.home_search_empty_message
          : context.l10n.home_search_list_empty_message,
      isShowButton: false,
    );
  }

  Widget _searchBarField(BuildContext context, SearchHomeViewState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        actionButton(context,
            onPressed: context.pop,
            icon: Icon(
              CupertinoIcons.chevron_back,
              size: 24,
              color: context.colorScheme.textPrimary,
            )),
        Expanded(
          child: SearchTextField(
            controller: state.searchController,
            hintText: context.l10n.home_search_hint_title,
            suffixIcon: (state.searchController.text.isNotEmpty)
                ? actionButton(
                    context,
                    icon: Icon(
                      Icons.close_rounded,
                      color: context.colorScheme.textDisabled,
                    ),
                    onPressed: notifier.onClear,
                  )
                : null,
            onChange: notifier.onChange,
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _tabView(BuildContext context) {
    final tabs = [
      context.l10n.common_matches_title,
      context.l10n.common_teams_title,
      context.l10n.common_tournaments,
      context.l10n.home_search_users_title,
    ];

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
              tabs[index],
              onTap: () {
                _controller.jumpToPage(index);
              },
              selected: index == _selectedTab,
            ),
          ),
        ),
      ),
    );
  }

  Widget _content(BuildContext context, SearchHomeViewState state) {
    return Expanded(
      child: PageView(
        controller: _controller,
        onPageChanged: notifier.onTabChange,
        children: [
          _listView(
            isLoading: state.loading,
            isSearchEmpty: state.searchController.text.isEmpty,
            itemCount: state.matches.length,
            builder: (context, index) {
              if (index == state.matches.length) {
                return _loadMoreWidget(
                  isLoading: state.loading,
                  onLoadMore: notifier.searchMatches,
                );
              }

              final match = state.matches[index];
              return MatchDetailCell(
                match: match,
                onTap: () =>
                    AppRoute.matchDetailTab(matchId: match.id).push(context),
              );
            },
          ),
          _listView(
            isLoading: state.loading,
            isSearchEmpty: state.searchController.text.isEmpty,
            itemCount: state.teams.length,
            separator: Divider(
              color: context.colorScheme.outline,
              height: 1,
            ),
            builder: (context, index) {
              if (index == state.teams.length) {
                return _loadMoreWidget(
                  isLoading: state.loading,
                  onLoadMore: notifier.searchTeam,
                );
              }

              final team = state.teams[index];
              return TeamDetailCell(
                team: team,
                onTap: () => AppRoute.teamDetail(teamId: team.id).push(context),
              );
            },
          ),
          _listView(
            isLoading: state.loading,
            isSearchEmpty: state.searchController.text.isEmpty,
            itemCount: state.tournaments.length,
            builder: (context, index) {
              if (index == state.tournaments.length) {
                return _loadMoreWidget(
                  isLoading: state.loading,
                  onLoadMore: notifier.searchTournament,
                );
              }

              final tournament = state.tournaments[index];
              return TournamentItem(
                tournament: tournament,
              );
            },
          ),
          _listView(
            isLoading: state.loading,
            isSearchEmpty: state.searchController.text.isEmpty,
            itemCount: state.users.length,
            separator: Divider(
              color: context.colorScheme.outline,
              height: 30,
            ),
            builder: (context, index) {
              if (index == state.users.length) {
                return _loadMoreWidget(
                  isLoading: state.loading,
                  onLoadMore: notifier.searchUser,
                );
              }
              final user = state.users[index];
              return UserDetailCell(
                  user: user,
                  onTap: () =>
                      AppRoute.userDetail(userId: user.id).push(context));
            },
          ),
        ],
      ),
    );
  }

  Widget _listView({
    required bool isSearchEmpty,
    required bool isLoading,
    required int itemCount,
    required Widget Function(BuildContext, int) builder,
    Widget? separator,
  }) {
    if (itemCount == 0 && isLoading) {
      return AppProgressIndicator();
    }
    if (itemCount == 0) {
      return _emptyScreen(context, isSearchEmpty: isSearchEmpty);
    }
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: itemCount + 1,
      itemBuilder: builder,
      separatorBuilder: (context, index) => index >= itemCount - 1
          ? const SizedBox()
          : separator ?? const SizedBox(height: 16),
    );
  }

  Widget _loadMoreWidget({
    required bool isLoading,
    required VoidCallback onLoadMore,
  }) {
    return OnVisibleCallback(
      onVisible: () => runPostFrame(onLoadMore),
      child: isLoading
          ? const Center(
              child: AppProgressIndicator(
              size: AppProgressIndicatorSize.small,
            ))
          : const SizedBox(),
    );
  }
}
