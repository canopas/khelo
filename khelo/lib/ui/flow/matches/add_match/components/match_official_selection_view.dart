import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/matches/add_match/add_match_view_model.dart';
import 'package:khelo/ui/flow/matches/add_match/components/section_title.dart';
import 'package:khelo/ui/flow/matches/add_match/match_officials/add_match_officials_view_model.dart';
import 'package:khelo/ui/flow/matches/add_match/match_officials/components/officials_cell_view.dart';

class MatchOfficialSelectionView extends StatelessWidget {
  final AddMatchViewNotifier notifier;
  final AddMatchViewState state;

  const MatchOfficialSelectionView({
    super.key,
    required this.notifier,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: context.l10n.add_match_match_officials_title),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              children: MatchOfficials.values
                  .map((official) => OfficialsCellView(
                        type: official,
                        isWholeCellTappable: true,
                        user: state.officials
                            .firstWhereOrNull(
                                (element) => element.type == official)
                            ?.user,
                        onCardTap: () async {
                          final officials = await AppRoute.addMatchOfficials(
                                  officials: state.officials)
                              .push<List<Officials>>(context);
                          if (officials != null && context.mounted) {
                            notifier.setOfficials(officials);
                          }
                        },
                      ))
                  .toList(),
            )),
      ],
    );
  }
}
