import 'package:data/api/match/match_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/match_detail_cell.dart';
import 'package:khelo/ui/app_route.dart';

class HomeViewAllScreen extends ConsumerWidget {
  final String title;
  final List<MatchModel> matches;

  const HomeViewAllScreen({
    super.key,
    required this.title,
    required this.matches,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppPage(
      title: title,
      body: Builder(builder: (context) => _body(context)),
    );
  }

  Widget _body(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: matches.length,
      itemBuilder: (context, index) {
        final match = matches[index];
        return MatchDetailCell(
          match: match,
          onTap: () => AppRoute.matchDetailTab(
            matchId: match.id ?? 'INVALID ID',
          ).push(context),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 16),
    );
  }
}
