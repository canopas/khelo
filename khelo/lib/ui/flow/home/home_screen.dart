import 'package:data/api/match/match_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/error_screen.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/formatter/date_formatter.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/home/home_view_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';
import 'package:style/widgets/ground_layout_view.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _controller =
      PageController(initialPage: 100, keepPage: true, viewportFraction: 0.9);
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
      title: context.l10n.common_matches_title,
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

    if (state.matches.isNotEmpty) {
      return _matchCardSlider(context, state);
    } else {
      return _emptyMatchView(context);
    }
  }

  Widget _matchCardSlider(
    BuildContext context,
    HomeViewState state,
  ) {
    return Column(
      children: [
        SizedBox(
          height: 176,
          child: state.matches.length == 1
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: _matchCell(context, state.matches.first),
                )
              : PageView.builder(
                  controller: _controller,
                  itemBuilder: (context, index) {
                    return _matchCell(
                        context, state.matches[index % state.matches.length]);
                  },
                ),
        ),
        const SizedBox(height: 16),
        if (state.matches.length >= 2) ...[
          SmoothPageIndicator(
            controller: _controller,
            count: state.matches.length,
            effect: WormEffect(
                dotHeight: 8,
                dotWidth: 8,
                dotColor: context.colorScheme.containerHigh,
                activeDotColor: context.colorScheme.primary,
                type: WormType.underground),
          )
        ],
        const SizedBox(height: 16),
        PrimaryButton(
          "show ground",
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return SingleChildScrollView(
                    child: Column(
                  children: [
                    const GroundLayoutView(),
                  ],
                ));
              },
            );
          },
        )
      ],
    );
  }

  Widget _matchCell(BuildContext context, MatchModel match) {
    return OnTapScale(
      onTap: () => AppRoute.matchDetailTab(matchId: match.id ?? "INVALID ID")
          .push(context),
      child: MediaQuery.withNoTextScaling(
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(horizontal: 8),
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
              const SizedBox(height: 16),
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
              maxLines: 2,
              style: AppTextStyle.subtitle1
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
            style: AppTextStyle.body2
                .copyWith(color: context.colorScheme.textPrimary),
            children: [
              WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Container(
                    height: 5,
                    width: 5,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.colorScheme.textPrimary,
                    ),
                  )),
              TextSpan(text: match.ground)
            ]));
  }

  Widget _emptyMatchView(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      margin: context.mediaQueryPadding + const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: context.colorScheme.primary)),
      child: IntrinsicHeight(
        child: Column(
          children: [
            Text(
              context.l10n.home_screen_no_matches_title,
              textAlign: TextAlign.center,
              style: AppTextStyle.subtitle1
                  .copyWith(color: context.colorScheme.textPrimary),
            ),
            const SizedBox(height: 8),
            Text(
              context.l10n.home_screen_no_matches_description_text,
              textAlign: TextAlign.center,
              style: AppTextStyle.body1
                  .copyWith(color: context.colorScheme.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
