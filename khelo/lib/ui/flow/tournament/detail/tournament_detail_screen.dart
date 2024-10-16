import 'package:cached_network_image/cached_network_image.dart';
import 'package:data/api/tournament/tournament_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khelo/components/empty_screen.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/formatter/date_formatter.dart';
import 'package:khelo/ui/flow/tournament/components/sliver_header_delegate.dart';
import 'package:khelo/ui/flow/tournament/detail/tabs/tournament_detail_overview_tab.dart';
import 'package:khelo/ui/flow/tournament/detail/tournament_detail_view_model.dart';
import 'package:style/button/more_option_button.dart';
import 'package:style/button/tab_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';

import '../../../../components/app_page.dart';
import '../../../../components/error_screen.dart';
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

  @override
  Widget build(BuildContext context) {
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

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 300,
          backgroundColor: context.colorScheme.surface,
          flexibleSpace: _flexibleTitle(context, state.tournament!),
          actions: [
            moreOptionButton(context),
          ],
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: SliverPersistentDelegate(
            child: _tabSelection(context),
            size: 60,
          ),
        ),
        SliverFillRemaining(
          child: _content(context, state),
        ),
      ],
    );
  }

  Widget _content(BuildContext context, TournamentDetailState state) {
    return PageView(
      controller: _controller,
      onPageChanged: notifier.onTabChange,
      children: [
        TournamentDetailOverviewTab(
          tournament: state.tournament!,
        ),
      ],
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
        title: isCollapsed
            ? AnimatedOpacity(
                opacity: isCollapsed ? 1 : 0,
                duration: const Duration(milliseconds: 100),
                child: Text(
                  tournament.name,
                  style: AppTextStyle.header2.copyWith(
                    color: context.colorScheme.textPrimary,
                  ),
                ),
              )
            : null,
        background: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: context.colorScheme.containerLow,
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
                          context.colorScheme.textPrimary,
                          BlendMode.srcIn,
                        ),
                      ),
                    )
                  : null,
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
            color: Colors.white,
            width: 1.5,
          ),
          backgroundColor: context.colorScheme.primary,
        ),
        const SizedBox(height: 16),
        Text(
          tournament.name,
          style: AppTextStyle.header1.copyWith(color: Colors.white),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            SvgPicture.asset(
              Assets.images.icCalendar,
              height: 24,
              width: 24,
              colorFilter: ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              context.l10n.tournament_detail_start_from_title(tournament
                  .start_date
                  .format(context, DateFormatType.dayMonth)),
              style: AppTextStyle.body1.copyWith(color: Colors.white),
            ),
          ],
        )
      ],
    );
  }
}
