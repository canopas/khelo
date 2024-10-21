import 'package:cached_network_image/cached_network_image.dart';
import 'package:data/api/tournament/tournament_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/domain/formatter/date_formatter.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/tournament/tournament_list_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';

import '../../../components/empty_screen.dart';
import '../../../components/error_screen.dart';
import '../../../gen/assets.gen.dart';
import 'components/sliver_header_delegate.dart';

class TournamentListScreen extends ConsumerStatefulWidget {
  const TournamentListScreen({super.key});

  @override
  ConsumerState<TournamentListScreen> createState() =>
      _TournamentListScreenState();
}

class _TournamentListScreenState extends ConsumerState<TournamentListScreen>
    with WidgetsBindingObserver {
  late TournamentListViewNotifier notifier;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    notifier = ref.read(tournamentListViewStateProvider.notifier);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      // deallocate resources
      notifier.dispose();
      WidgetsBinding.instance.removeObserver(this);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      body: Builder(
        builder: (context) => _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    final state = ref.watch(tournamentListViewStateProvider);
    if (state.loading) {
      return const Center(child: AppProgressIndicator());
    }
    if (state.error != null) {
      return ErrorScreen(
        error: state.error,
        onRetryTap: notifier.loadTournaments,
      );
    }
    if (state.groupTournaments.isEmpty) {
      return EmptyScreen(
        title: context.l10n.tournament_list_empty_list_title,
        description: context.l10n.tournament_list_empty_list_description,
        isShowButton: false,
      );
    }

    return _content(context, state);
  }

  Widget _content(BuildContext context, TournamentListViewState state) {
    return CustomScrollView(
      slivers: [
        ..._tournaments(context, state),
        SliverToBoxAdapter(
          child: SizedBox(height: 16 + context.mediaQueryPadding.bottom),
        ),
      ],
    );
  }

  List<Widget> _tournaments(
      BuildContext context, TournamentListViewState state) {
    return List.generate(state.groupTournaments.length, (bookingIndex) {
      final DateTime key = state.groupTournaments.keys.elementAt(bookingIndex);
      final List<TournamentModel> tournaments = state.groupTournaments[key]!;
      return SliverMainAxisGroup(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverPersistentDelegate(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  key.format(context, DateFormatType.monthYear),
                  style: AppTextStyle.header3
                      .copyWith(color: context.colorScheme.textPrimary),
                  textScaler: TextScaler.noScaling,
                ),
              ),
            ),
          ),
          SliverList.builder(
            itemBuilder: (BuildContext context, int index) {
              final tournament = tournaments[index];
              return _tournamentItem(context, tournament);
            },
            itemCount: tournaments.length,
          ),
        ],
      );
    });
  }

  Widget _tournamentItem(BuildContext context, TournamentModel tournament) {
    return OnTapScale(
      onTap: () =>
          AppRoute.tournamentDetail(tournamentId: tournament.id).push(context),
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: context.colorScheme.containerLow,
            borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            _profileImage(context, tournament.profile_img_url),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tournament.name,
                    style: AppTextStyle.header4.copyWith(
                      color: context.colorScheme.textPrimary,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    context.l10n.tournament_list_match_title(
                        tournament.match_ids.length),
                    style: AppTextStyle.subtitle2.copyWith(
                      color: context.colorScheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  _scheduleAndTypeView(context, tournament),
                ],
              ),
            ),
            const SizedBox(width: 16),
            SvgPicture.asset(Assets.images.icArrowForward,
                colorFilter: ColorFilter.mode(
                  context.colorScheme.textDisabled,
                  BlendMode.srcATop,
                ))
          ],
        ),
      ),
    );
  }

  Widget _profileImage(BuildContext context, String? imageUrl) {
    return Container(
      height: 82,
      width: 82,
      decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(6),
          image: (imageUrl != null)
              ? DecorationImage(
                  image: CachedNetworkImageProvider(imageUrl),
                  fit: BoxFit.cover,
                )
              : null),
      child: imageUrl == null
          ? Center(
              child: SvgPicture.asset(Assets.images.icTournaments,
                  height: 32,
                  width: 32,
                  colorFilter: ColorFilter.mode(
                    context.colorScheme.textSecondary,
                    BlendMode.srcATop,
                  )),
            )
          : null,
    );
  }

  Widget _scheduleAndTypeView(
    BuildContext context,
    TournamentModel tournament,
  ) {
    return Text.rich(TextSpan(
        text: DateFormatter.formatDateRange(
          context,
          startDate: tournament.start_date,
          endDate: tournament.end_date,
          formatType: DateFormatType.dayMonth,
        ),
        style: AppTextStyle.caption
            .copyWith(color: context.colorScheme.textDisabled),
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
          TextSpan(text: tournament.type.getString(context))
        ]));
  }
}
