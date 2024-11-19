import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/match_detail_cell.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/widget_extension.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/home/home_view_model.dart';
import 'package:khelo/ui/flow/home/view_all/home_view_all_view_model.dart';
import 'package:style/callback/on_visible_callback.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';

import '../../../../components/error_screen.dart';
import '../components/tournament_item.dart';

class HomeViewAllScreen extends ConsumerStatefulWidget {
  final MatchStatusLabel? status;
  final bool isTournament;

  const HomeViewAllScreen({
    super.key,
    this.status,
    this.isTournament = false,
  });

  @override
  ConsumerState<HomeViewAllScreen> createState() => _HomeViewAllScreenState();
}

class _HomeViewAllScreenState extends ConsumerState<HomeViewAllScreen> {
  late HomeViewAllViewNotifier notifier;

  @override
  void initState() {
    super.initState();
    notifier = ref.read(homeViewAllViewProvider.notifier);
    runPostFrame(() => notifier.setData(
          widget.status?.convertStatus() ?? [],
          widget.isTournament,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: widget.isTournament
          ? context.l10n.common_tournaments
          : widget.status?.getString(context),
      body: Builder(builder: (context) {
        return _body(context);
      }),
    );
  }

  Widget _body(BuildContext context) {
    final state = ref.watch(homeViewAllViewProvider);

    if (state.loading) {
      return const Center(child: AppProgressIndicator());
    }
    if (state.error != null) {
      return ErrorScreen(
        error: state.error,
        onRetryTap: notifier.loadMatches,
      );
    }

    return Padding(
      padding: context.mediaQueryPadding,
      child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: (widget.isTournament
                  ? state.tournaments.length
                  : state.matches.length) +
              1,
          itemBuilder: (context, index) {
            if (index <
                (widget.isTournament
                    ? state.tournaments.length
                    : state.matches.length)) {
              if (widget.isTournament) {
                final tournament = state.tournaments[index];
                return TournamentItem(tournament: tournament);
              } else {
                final match = state.matches[index];
                return MatchDetailCell(
                  match: match,
                  onTap: () =>
                      AppRoute.matchDetailTab(matchId: match.id).push(context),
                );
              }
            }
            return OnVisibleCallback(
                onVisible: () => runPostFrame(() => widget.isTournament
                    ? notifier.loadTournaments()
                    : notifier.loadMatches()),
                child: (state.loading &&
                        (widget.isTournament
                            ? state.tournaments.isNotEmpty
                            : state.matches.isNotEmpty))
                    ? const Center(child: AppProgressIndicator())
                    : const SizedBox());
          },
          separatorBuilder: (context, index) => const SizedBox(height: 16)),
    );
  }
}
