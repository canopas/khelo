import 'package:data/api/match/match_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/match_detail_cell.dart';
import 'package:style/extensions/context_extensions.dart';

class TournamentDetailMatchesTab extends ConsumerWidget {
  final List<MatchModel> matches;

  const TournamentDetailMatchesTab({
    super.key,
    required this.matches,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      itemCount: matches.length,
      padding: context.mediaQueryPadding.copyWith(top: 0) +
          EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 40),
      itemBuilder: (context, index) {
        return MatchDetailCell(
          match: matches[index],
          onTap: () {},
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 16),
    );
  }
}
