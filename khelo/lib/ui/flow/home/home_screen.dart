import 'package:data/api/match/match_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/domain/formatter/date_formatter.dart';
import 'package:khelo/ui/flow/home/home_view_model.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewStateProvider);

    return AppPage(
      title: context.l10n.home_screen_title,
      body: _body(context, state),
    );
  }

  Widget _body(
    BuildContext context,
    HomeViewState state,
  ) {
    if (state.loading) {
      return const Center(child: AppProgressIndicator());
    }

    return ListView(
      padding: context.mediaQueryPadding,
      children: [
        _matchCardSlider(context, state),
      ],
    );
  }

  Widget _matchCardSlider(
    BuildContext context,
    HomeViewState state,
  ) {
    return SizedBox(
      height: 220,
      child: state.matches.length == 1
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: _matchCell(context, state.matches.first),
            )
          : PageView.builder(
              controller: PageController(
                viewportFraction: 0.9,
                initialPage: state.matches.length * 100,
              ),
              itemBuilder: (BuildContext context, int index) {
                return _matchCell(context,
                    state.matches[(index % state.matches.length).toInt()]);
              },
            ),
    );
  }

  Widget _matchCell(BuildContext context, MatchModel match) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: context.colorScheme.outline),
        borderRadius: BorderRadius.circular(20),
        color: context.colorScheme.containerLow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    child: _teamNameView(
                        context,
                        match.teams.first,
                        match.current_playing_team_id ==
                            match.teams.first.team.id)),
                VerticalDivider(
                  color: context.colorScheme.outline,
                  thickness: 2,
                ),
                Expanded(
                    child: _teamNameView(
                        context,
                        match.teams.last,
                        match.current_playing_team_id ==
                            match.teams.last.team.id)),
              ],
            ),
          ),
          _matchDetailView(context, match),
        ],
      ),
    );
  }

  Widget _teamNameView(
    BuildContext context,
    MatchTeamModel team,
    bool isCurrentlyPlaying,
  ) {
    return Column(
      children: [
        ImageAvatar(
          initial: team.team.name[0].toUpperCase(),
          imageUrl: team.team.profile_img_url,
          size: 50,
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          team.team.name,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: AppTextStyle.header4.copyWith(
              color: isCurrentlyPlaying
                  ? context.colorScheme.primary
                  : context.colorScheme.textPrimary),
          maxLines: 3,
        ),
        const SizedBox(
          height: 4,
        ),
        Text.rich(TextSpan(
            text: (team.run ?? 0).toString(),
            style: AppTextStyle.subtitle1
                .copyWith(color: context.colorScheme.textPrimary, fontSize: 24),
            children: [
              TextSpan(
                  text: " (${team.over ?? 0})",
                  style: AppTextStyle.body1
                      .copyWith(color: context.colorScheme.textPrimary))
            ])),
        Text("${context.l10n.common_wicket_taken_title}: ${team.wicket ?? 0}",
            style: AppTextStyle.subtitle2
                .copyWith(color: context.colorScheme.textPrimary)),
      ],
    );
  }

  Widget _matchDetailView(
    BuildContext context,
    MatchModel match,
  ) {
    return Column(
      children: [
        Divider(
          color: context.colorScheme.outline,
          thickness: 2,
        ),
        Text(
          "${match.ground} - ${match.match_type.getString(context)} - ${context.l10n.match_list_overs_title(match.number_of_over)}",
          style: AppTextStyle.subtitle2
              .copyWith(color: context.colorScheme.textPrimary),
        ),
        Text(match.start_time.format(context, DateFormatType.dateAndTime),
            style: AppTextStyle.subtitle2
                .copyWith(color: context.colorScheme.textPrimary)),
      ],
    );
  }
}
