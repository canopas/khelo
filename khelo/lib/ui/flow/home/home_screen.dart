import 'package:data/api/match/match_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/empty_screen.dart';
import 'package:khelo/components/error_screen.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/formatter/date_formatter.dart';
import 'package:khelo/ui/app_route.dart';
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
      titleWidget: Text(
        context.l10n.app_title,
        style: AppTextStyle.appHeader.copyWith(
          color: context.colorScheme.primary,
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
                onPressed: () =>
                    AppRoute.searchHome(matches: state.matches).push(context),
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
        onRetryTap: notifier.onResume,
      );
    }
    return ListView(
      padding:
          context.mediaQueryPadding + const EdgeInsets.symmetric(vertical: 16),
      children: [
        _actionRow(context),
        const SizedBox(height: 16),
        (state.matches.isNotEmpty)
            ? _content(context, state)
            : SizedBox(
                height: context.mediaQuerySize.height / 1.5,
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
      height: 64,
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                _createActionView(
                  context,
                  title: context.l10n.home_screen_set_up_match_title,
                  btnText: context.l10n.home_screen_create_match_btn,
                  onTap: () => AppRoute.addMatch().push(context),
                ),
                _createActionView(
                  context,
                  title: context.l10n.home_screen_set_up_team_title,
                  btnText: context.l10n.home_screen_create_team_btn,
                  onTap: () => AppRoute.addTeam().push(context),
                ),
              ],
            ),
          )),
    );
  }

  Widget _content(
    BuildContext context,
    HomeViewState state,
  ) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: state.groupMatches.length,
      itemBuilder: (context, index) {
        final item = state.groupMatches.entries.elementAt(index);
        return item.value.isNotEmpty
            ? Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _matchHeader(
                    context,
                    header: item.key.getString(context),
                    isViewAllShow: item.value.length > 3,
                    onViewAll: () => AppRoute.viewAll(item.key).push(context),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: item.value
                            .map((match) => _matchCell(context, match))
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

  Widget _matchHeader(
    BuildContext context, {
    required String header,
    required bool isViewAllShow,
    required Function() onViewAll,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            header,
            style: AppTextStyle.header3
                .copyWith(color: context.colorScheme.textPrimary),
          ),
          const Spacer(),
          Opacity(
            opacity: isViewAllShow ? 1 : 0,
            child: TextButton(
                onPressed: onViewAll,
                child: Text(
                  context.l10n.home_screen_view_all_btn,
                  style: AppTextStyle.button.copyWith(
                    color: context.colorScheme.primary,
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Widget _matchCell(BuildContext context, MatchModel match) {
    return OnTapScale(
      onTap: () => AppRoute.matchDetailTab(matchId: match.id).push(context),
      child: MediaQuery.withNoTextScaling(
        child: Container(
          width: context.mediaQuerySize.width * 0.83,
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: context.colorScheme.containerLow,
            border: Border.all(color: context.colorScheme.outline),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _matchDetailView(context, match),
              const SizedBox(height: 24),
              _teamScore(
                context,
                match.teams.first,
                match.teams.elementAt(1).wicket,
              ),
              const SizedBox(height: 22),
              _teamScore(
                context,
                match.teams.elementAt(1),
                match.teams.first.wicket,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _teamScore(
    BuildContext context,
    MatchTeamModel matchTeam,
    int wicket,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ImageAvatar(
          initial: matchTeam.team.name[0].toUpperCase(),
          imageUrl: matchTeam.team.profile_img_url,
          size: 32,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(matchTeam.team.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: AppTextStyle.subtitle3
                  .copyWith(color: context.colorScheme.textPrimary)),
        ),
        if (matchTeam.over != 0) ...[
          Text.rich(TextSpan(
              text: "${matchTeam.run}-$wicket",
              style: AppTextStyle.subtitle2
                  .copyWith(color: context.colorScheme.textPrimary),
              children: [
                TextSpan(
                  text: " ${matchTeam.over}",
                  style: AppTextStyle.body2
                      .copyWith(color: context.colorScheme.textSecondary),
                )
              ])),
        ],
      ],
    );
  }

  Widget _matchDetailView(
    BuildContext context,
    MatchModel match,
  ) {
    return Text.rich(
        overflow: TextOverflow.ellipsis,
        TextSpan(
            text: match.start_time.format(context, DateFormatType.dateAndTime),
            style: AppTextStyle.caption
                .copyWith(color: context.colorScheme.textSecondary),
            children: [
              WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Container(
                    height: 5,
                    width: 5,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.colorScheme.textSecondary,
                    ),
                  )),
              TextSpan(text: match.ground)
            ]));
  }

  Widget _createActionView(
    BuildContext context, {
    required String title,
    required String btnText,
    required Function() onTap,
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
                  style: AppTextStyle.body1
                      .copyWith(color: context.colorScheme.textPrimary),
                ),
                Text(
                  btnText,
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
