import 'package:data/api/leaderboard/leaderboard_model.dart';
import 'package:data/api/tournament/tournament_model.dart';
import 'package:data/api/user/user_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/empty_screen.dart';
import 'package:khelo/components/error_screen.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/home/components/match_item.dart';
import 'package:khelo/ui/flow/home/components/tournament_item.dart';
import 'package:khelo/ui/flow/home/home_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/button/action_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';

import '../../../gen/assets.gen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late HomeViewNotifier notifier;

  @override
  void initState() {
    super.initState();
    notifier = ref.read(homeViewStateProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeViewStateProvider);

    return AppPage(
      titleWidget: SvgPicture.asset(
        Assets.images.icAppLogo,
        height: 28,
        width: 28,
        colorFilter: ColorFilter.mode(
          context.colorScheme.primary,
          BlendMode.srcATop,
        ),
      ),
      actions: (state.matches.isNotEmpty)
          ? [
              actionButton(
                context,
                icon: SvgPicture.asset(
                  Assets.images.icSearch,
                  colorFilter: ColorFilter.mode(
                    context.colorScheme.textPrimary,
                    BlendMode.srcATop,
                  ),
                ),
                onPressed: () => AppRoute.searchHome.push(context),
              )
            ]
          : null,
      body: Builder(builder: (context) {
        return _body(context, notifier, state);
      }),
    );
  }

  Widget _body(
    BuildContext context,
    HomeViewNotifier notifier,
    HomeViewState state,
  ) {
    if (state.loading) {
      return const Center(child: AppProgressIndicator());
    }
    if (state.error != null) {
      return ErrorScreen(
        error: state.error,
        onRetryTap: notifier.loadData,
      );
    }
    return ListView(
      padding:
          context.mediaQueryPadding + const EdgeInsets.symmetric(vertical: 16),
      children: [
        _actionRow(context),
        const SizedBox(height: 8),
        if (state.tournaments.isNotEmpty) ...[
          _tournamentList(context, state.tournaments),
          const SizedBox(height: 8),
        ],
        if (state.leaderboard.isNotEmpty) ...[
          _leaderboardList(context, state.leaderboard),
          const SizedBox(height: 8),
        ],
        (state.matches.isNotEmpty)
            ? _content(context, state)
            : SizedBox(
                height: context.mediaQuerySize.height /
                    (state.tournaments.isEmpty ? 1.3 : 2),
                child: EmptyScreen(
                  title: context.l10n.home_screen_no_matches_title,
                  description:
                      context.l10n.home_screen_no_matches_description_text,
                  isShowButton: false,
                ),
              ),
      ],
    );
  }

  Widget _actionRow(BuildContext context) {
    return SizedBox(
      height: 65,
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                _createActionView(
                  context,
                  title: context.l10n.home_screen_set_up_team_title,
                  btnText: context.l10n.common_create_team_title,
                  onTap: () => AppRoute.addTeam().push(context),
                ),
                _createActionView(
                  context,
                  title: context.l10n.home_screen_set_up_match_title,
                  btnText: context.l10n.home_screen_create_match_btn,
                  onTap: () => AppRoute.addMatch().push(context),
                ),
                _createActionView(
                  context,
                  title: context.l10n.home_screen_set_up_tournament_title,
                  btnText: context.l10n.home_screen_create_tournament_btn,
                  onTap: () => AppRoute.addTournament().push(context),
                ),
              ],
            ),
          )),
    );
  }

  Widget _tournamentList(
    BuildContext context,
    List<TournamentModel> tournaments,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _header(
          context,
          header: context.l10n.common_tournaments,
          isViewAllShow: tournaments.length > 2,
          onViewAll: () => AppRoute.viewAll(isTournament: true).push(context),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: tournaments
                  .map((tournament) => TournamentItem(
                        tournament: tournament,
                        size: Size.fromWidth(360),
                        margin: EdgeInsets.symmetric(horizontal: 8),
                      ))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _leaderboardList(
    BuildContext context,
    List<LeaderboardModel> leaderboard,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _header(
          context,
          header: context.l10n.common_leaderboard,
          isViewAllShow: false,
          onViewAll: () {},
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: leaderboard
                  .map((data) => _leaderboardCell(context, data))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _leaderboardCell(BuildContext context, LeaderboardModel leaderboard) {
    return OnTapScale(
      onTap: () =>
          AppRoute.leaderboard(selectedField: leaderboard.type).push(context),
      child: Container(
        width: Size.fromWidth(360).width,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: context.colorScheme.outline)),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    leaderboard.type.getString(context),
                    style: AppTextStyle.caption.copyWith(
                      color: context.colorScheme.textDisabled,
                    ),
                  ),
                ),
                SvgPicture.asset(
                  Assets.images.icArrowForward,
                  width: 16,
                  height: 16,
                  colorFilter: ColorFilter.mode(
                    context.colorScheme.textDisabled,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            _leaderboardPlayerListView(leaderboard.players),
          ],
        ),
      ),
    );
  }

  Widget _leaderboardPlayerListView(List<LeaderboardPlayer> players) {
    return Row(
      spacing: 8,
      children: [
        for (int rank = 0; rank < players.length; rank++)
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: context.colorScheme.containerLow,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: context.colorScheme.outline)),
              child: _leaderboardPlayerProfileView(
                  players.elementAt(rank).user, rank <= 2 ? rank + 1 : null),
            ),
          ),
      ],
    );
  }

  Widget _leaderboardPlayerProfileView(UserModel? user, int? rank) {
    return Column(
      children: [
        Stack(
          children: [
            ImageAvatar(
              initial: user?.nameInitial ?? "?",
              imageUrl: user?.profile_img_url,
              size: 48,
            ),
            if (rank != null)
              Positioned(
                right: 0,
                bottom: 0,
                child: CircleAvatar(
                  backgroundColor: context.colorScheme.primary,
                  radius: 9,
                  child: Text(
                    rank.toString(),
                    style: AppTextStyle.caption.copyWith(
                        color: context.colorScheme.onPrimary, fontSize: 10),
                  ),
                ),
              )
          ],
        ),
        Text(
          user?.name ?? context.l10n.commonDeactivatedUser,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyle.body1
              .copyWith(color: context.colorScheme.textPrimary),
        ),
      ],
    );
  }

  Widget _content(
    BuildContext context,
    HomeViewState state,
  ) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: state.groupMatches.length,
      itemBuilder: (context, index) {
        final item = state.groupMatches.entries.elementAt(index);
        return item.value.isNotEmpty
            ? Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _header(
                    context,
                    header: item.key.getString(context),
                    isViewAllShow: item.value.length > 3,
                    onViewAll: () =>
                        AppRoute.viewAll(status: item.key).push(context),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: item.value
                            .map((match) => MatchItem(match: match))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              )
            : const SizedBox();
      },
    );
  }

  Widget _header(
    BuildContext context, {
    required String header,
    required bool isViewAllShow,
    required VoidCallback onViewAll,
  }) {
    return OnTapScale(
      onTap: onViewAll,
      enabled: isViewAllShow,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                header,
                style: AppTextStyle.header3
                    .copyWith(color: context.colorScheme.textPrimary),
              ),
            ),
            Visibility(
                visible: isViewAllShow,
                child: Text(
                  context.l10n.common_view_all,
                  style: AppTextStyle.button.copyWith(
                    color: context.colorScheme.primary,
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _createActionView(
    BuildContext context, {
    required String title,
    required String btnText,
    required VoidCallback onTap,
  }) {
    return OnTapScale(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: context.colorScheme.outline)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundColor: context.colorScheme.containerLow,
              child: Icon(Icons.add, color: context.colorScheme.primary),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  textScaler: TextScaler.noScaling,
                  style: AppTextStyle.body1
                      .copyWith(color: context.colorScheme.textPrimary),
                ),
                Text(
                  btnText,
                  textScaler: TextScaler.noScaling,
                  style: AppTextStyle.button
                      .copyWith(color: context.colorScheme.primary),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
