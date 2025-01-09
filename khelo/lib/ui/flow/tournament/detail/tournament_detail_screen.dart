import 'dart:io';

import 'package:data/api/team/team_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/empty_screen.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/tournament/components/sliver_header_delegate.dart';
import 'package:khelo/ui/flow/tournament/detail/components/flexible_space.dart';
import 'package:khelo/ui/flow/tournament/detail/tabs/tournament_detail_matches_tab.dart';
import 'package:khelo/ui/flow/tournament/detail/tabs/tournament_detail_overview_tab.dart';
import 'package:khelo/ui/flow/tournament/detail/tabs/tournament_detail_points_table_tab.dart';
import 'package:khelo/ui/flow/tournament/detail/tabs/tournament_detail_stats_tab.dart';
import 'package:khelo/ui/flow/tournament/detail/tabs/tournament_detail_teams_tab.dart';
import 'package:khelo/ui/flow/tournament/detail/tournament_detail_view_model.dart';
import 'package:share_plus/share_plus.dart';
import 'package:style/button/action_button.dart';
import 'package:style/button/more_option_button.dart';
import 'package:style/button/tab_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';

import '../../../../components/action_bottom_sheet.dart';
import '../../../../components/app_page.dart';
import '../../../../components/error_screen.dart';
import '../../../../components/error_snackbar.dart';
import '../../../../domain/extensions/widget_extension.dart';
import '../../../../main.dart';

class TournamentDetailScreen extends ConsumerStatefulWidget {
  final String tournamentId;

  const TournamentDetailScreen({
    super.key,
    required this.tournamentId,
  });

  @override
  ConsumerState<TournamentDetailScreen> createState() =>
      _TournamentDetailScreenState();
}

class _TournamentDetailScreenState
    extends ConsumerState<TournamentDetailScreen> {
  late TournamentDetailStateViewNotifier notifier;
  late PageController _controller;

  int get _selectedTab => _controller.hasClients
      ? _controller.page?.round() ?? 0
      : _controller.initialPage;

  @override
  void initState() {
    super.initState();
    notifier = ref.read(tournamentDetailStateProvider.notifier);
    _controller = PageController(
      initialPage: ref.read(tournamentDetailStateProvider).selectedTab,
    );
    runPostFrame(() => notifier.setData(widget.tournamentId));
  }

  void _observeActionError(BuildContext context) {
    ref.listen(
        tournamentDetailStateProvider.select((value) => value.actionError),
        (previous, next) {
      if (next != null) {
        showErrorSnackBar(context: context, error: next);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _observeActionError(context);

    final state = ref.watch(tournamentDetailStateProvider);

    return AppPage(
      body: Builder(builder: (context) {
        return _body(context, state);
      }),
    );
  }

  Widget _body(BuildContext context, TournamentDetailState state) {
    if (state.loading) {
      return const Center(child: AppProgressIndicator());
    }
    if (state.error != null) {
      return ErrorScreen(
        error: state.error,
        onRetryTap: notifier.loadTournament,
      );
    }

    if (state.tournament == null) {
      return EmptyScreen(
        title: context.l10n.tournament_detail_not_found_title,
        description: context.l10n.tournament_detail_not_found_description,
        isShowButton: false,
      );
    }

    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            pinned: true,
            expandedHeight: 300,
            backgroundColor: context.colorScheme.surface,
            leading: _backButton(context),
            flexibleSpace: FlexibleSpace(tournament: state.tournament!),
            actions: [
              _shareButton(
                context,
                onShareTap: () => Share.shareUri(Uri.parse(
                    "$appBaseUrl/tournament/${state.tournament!.id}")),
              ),
              if (state.tournament!.created_by == state.currentUserId ||
                  state.tournament!.members
                      .any((element) => element.id == state.currentUserId)) ...[
                moreOptionButton(
                  context,
                  size: 20,
                  backgroundColor: context.colorScheme.containerHighOnSurface
                      .withValues(alpha: 0.4),
                  onPressed: () => _moreActionButton(context, state),
                )
              ],
            ],
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverPersistentDelegate(
              child: _tabSelection(context),
              size: 70,
            ),
          ),
        ];
      },
      body: _content(context, state),
    );
  }

  Widget _content(BuildContext context, TournamentDetailState state) {
    return Container(
      color: context.colorScheme.containerLow,
      child: PageView(
        controller: _controller,
        onPageChanged: notifier.onTabChange,
        children: [
          TournamentDetailOverviewTab(
            controller: _controller,
          ),
          TournamentDetailTeamsTab(
            onSelected: notifier.onTeamsSelected,
          ),
          TournamentDetailMatchesTab(
            onMatchFilter: notifier.onMatchFilter,
            onAddMatchTap: () => _handleAddMatchTap(context, state),
          ),
          TournamentDetailPointsTableTab(
            teamStats: state.teamStats,
          ),
          TournamentDetailStatsTab(
            onFiltered: notifier.onStatFilter,
          ),
        ],
      ),
    );
  }

  Widget _tabSelection(BuildContext context) {
    final tabs = [
      context.l10n.tournament_detail_overview_tab,
      context.l10n.common_teams_title,
      context.l10n.common_matches_title,
      context.l10n.tournament_detail_points_table_tab,
      context.l10n.common_stats_title,
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          tabs.length,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: TabButton(
              tabs[index],
              selected: index == _selectedTab,
              onTap: () {
                _controller.jumpToPage(index);
              },
            ),
          ),
        ),
      ),
    );
  }

  void _moreActionButton(
    BuildContext context,
    TournamentDetailState state,
  ) async {
    return showActionBottomSheet(context: context, items: [
      BottomSheetAction(
        title: context.l10n.tournament_detail_teams_select_btn,
        onTap: () async {
          context.pop();
          final selectedTeams = await AppRoute.teamSelection(
                  selectedTeams: state.tournament!.teams)
              .push<List<TeamModel>>(context);
          if (context.mounted && selectedTeams != null) {
            notifier.onTeamsSelected(selectedTeams);
          }
        },
      ),
      BottomSheetAction(
        title: context.l10n.tournament_detail_matches_add_btn,
        onTap: () async {
          context.pop();
          _handleAddMatchTap(context, state);
        },
      ),
      BottomSheetAction(
        title: context.l10n.tournament_detail_members_title,
        onTap: () async {
          context.pop();
          AppRoute.memberSelection(tournament: state.tournament!).push(context);
        },
      ),
      BottomSheetAction(
        title: context.l10n.tournament_detail_edit_title,
        onTap: () async {
          context.pop();
          AppRoute.addTournament(editTournament: state.tournament!)
              .push(context);
        },
      ),
    ]);
  }

  Widget _backButton(BuildContext context) {
    return actionButton(context,
        onPressed: context.pop,
        icon: CircleAvatar(
          radius: 16,
          backgroundColor:
              context.colorScheme.containerHighOnSurface.withValues(alpha: 0.4),
          child: Icon(
            Platform.isIOS ? Icons.arrow_back_ios_new : Icons.arrow_back,
            size: 20,
            color: context.colorScheme.textPrimary,
          ),
        ));
  }

  Widget _shareButton(BuildContext context, {required Function() onShareTap}) {
    return actionButton(
      context,
      onPressed: onShareTap,
      icon: CircleAvatar(
        radius: 16,
        backgroundColor:
            context.colorScheme.containerHighOnSurface.withValues(alpha: 0.4),
        child: Icon(
          Platform.isIOS ? Icons.share : Icons.share_outlined,
          size: 20,
          color: context.colorScheme.textPrimary,
        ),
      ),
    );
  }

  void _handleAddMatchTap(
      BuildContext context, TournamentDetailState state) async {
    if (state.tournament == null) {
      return;
    }
    if (state.tournament!.teams.length >= state.tournament!.type.minTeamReq) {
      await AppRoute.matchSelection(tournamentId: state.tournament!.id)
          .push(context);
    } else {
      showErrorSnackBar(
          context: context,
          error: context.l10n.add_tournament_select_min_team_error(
              state.tournament!.type.minTeamReq));
    }
  }
}
