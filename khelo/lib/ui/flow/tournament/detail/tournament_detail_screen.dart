import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:data/api/team/team_model.dart';
import 'package:data/api/tournament/tournament_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/empty_screen.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/formatter/date_formatter.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/tournament/components/sliver_header_delegate.dart';
import 'package:khelo/ui/flow/tournament/detail/tabs/tournament_detail_matches_tab.dart';
import 'package:khelo/ui/flow/tournament/detail/tabs/tournament_detail_overview_tab.dart';
import 'package:khelo/ui/flow/tournament/detail/tabs/tournament_detail_points_table_tab.dart';
import 'package:khelo/ui/flow/tournament/detail/tabs/tournament_detail_stats_tab.dart';
import 'package:khelo/ui/flow/tournament/detail/tabs/tournament_detail_teams_tab.dart';
import 'package:khelo/ui/flow/tournament/detail/tournament_detail_view_model.dart';
import 'package:style/button/action_button.dart';
import 'package:style/button/more_option_button.dart';
import 'package:style/button/tab_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';
import 'package:style/theme/colors.dart';

import '../../../../components/action_bottom_sheet.dart';
import '../../../../components/app_page.dart';
import '../../../../components/error_screen.dart';
import '../../../../components/error_snackbar.dart';
import '../../../../domain/extensions/widget_extension.dart';
import '../../../../gen/assets.gen.dart';

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
            flexibleSpace: _flexibleTitle(context, state.tournament!),
            actions: state.tournament!.created_by == state.currentUserId ||
                    state.tournament!.members
                        .any((element) => element.id == state.currentUserId)
                ? [
                    moreOptionButton(
                      context,
                      size: 20,
                      backgroundColor: context
                          .colorScheme.containerHighOnSurface
                          .withOpacity(0.4),
                      onPressed: () => _moreActionButton(context, state),
                    ),
                  ]
                : null,
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
            tournament: state.tournament!,
            controller: _controller,
          ),
          TournamentDetailTeamsTab(
            onSelected: notifier.onTeamsSelected,
          ),
          TournamentDetailMatchesTab(
            onMatchFilter: notifier.onMatchFilter,
            onSelected: notifier.onMatchesSelected,
          ),
          TournamentDetailPointsTableTab(
            teamPoints: state.teamPoints,
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
      context.l10n.tournament_detail_teams_tab,
      context.l10n.tournament_detail_matches_tab,
      context.l10n.tournament_detail_points_table_tab,
      context.l10n.tournament_detail_stats_tab,
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

  Widget _flexibleTitle(BuildContext context, TournamentModel tournament) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final isCollapsed = constraints.biggest.height < 150;

      return FlexibleSpaceBar(
        centerTitle: true,
        title: isCollapsed
            ? AnimatedOpacity(
                opacity: isCollapsed ? 1 : 0,
                duration: const Duration(milliseconds: 100),
                child: Padding(
                  padding: const EdgeInsets.only(left: 64, right: 48),
                  child: Text(
                    tournament.name,
                    style: AppTextStyle.header2.copyWith(
                      color: context.colorScheme.textPrimary,
                    ),
                    overflow: TextOverflow.ellipsis,
                    textScaler: TextScaler.noScaling,
                  ),
                ),
              )
            : null,
        background: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: context.colorScheme.containerHigh,
                image: (tournament.banner_img_url != null)
                    ? DecorationImage(
                        image: CachedNetworkImageProvider(
                            tournament.banner_img_url ?? ''),
                        fit: BoxFit.fill,
                      )
                    : null,
              ),
              child: (tournament.banner_img_url == null)
                  ? Center(
                      child: SvgPicture.asset(
                        Assets.images.icTournaments,
                        colorFilter: ColorFilter.mode(
                          context.colorScheme.textSecondary,
                          BlendMode.srcIn,
                        ),
                      ),
                    )
                  : null,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    surfaceDarkColor.withOpacity(0.2),
                    surfaceDarkColor.withOpacity(0.8),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 16,
              bottom: 24,
              child: AnimatedOpacity(
                opacity: isCollapsed ? 0 : 1,
                duration: const Duration(milliseconds: 100),
                child: _profileView(context, tournament),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _profileView(BuildContext context, TournamentModel tournament) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageAvatar(
          initial: tournament.name.characters.first.toUpperCase(),
          size: 80,
          imageUrl: tournament.profile_img_url,
          border: Border.all(
            color: surfaceLightColor,
            width: 1.5,
          ),
          backgroundColor: context.colorScheme.primary,
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: context.mediaQuerySize.width - 32,
          child: Text(
            tournament.name,
            style: AppTextStyle.header1.copyWith(
              color: surfaceLightColor,
            ),
            overflow: TextOverflow.ellipsis,
            textScaler: TextScaler.noScaling,
            maxLines: 2,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            SvgPicture.asset(
              Assets.images.icCalendar,
              height: 24,
              width: 24,
              colorFilter: ColorFilter.mode(
                surfaceLightColor,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              context.l10n.tournament_detail_start_from_title(tournament
                  .start_date
                  .format(context, DateFormatType.dayMonth)),
              style: AppTextStyle.body1.copyWith(
                color: surfaceLightColor,
              ),
            ),
          ],
        )
      ],
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
          // TODO: Add matches
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
        icon: Container(
          height: 28,
          width: 28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.colorScheme.containerHighOnSurface.withOpacity(0.4),
          ),
          child: Icon(
            Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
            size: 20,
            color: context.colorScheme.textPrimary,
          ),
        ));
  }
}
