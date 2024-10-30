import 'package:data/api/match/match_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/action_bottom_sheet.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/domain/extensions/string_extensions.dart';
import 'package:khelo/domain/extensions/widget_extension.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/tournament/match_selection/match_selection_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/button/action_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';
import 'package:style/text/search_text_field.dart';

import '../../../../domain/formatter/date_formatter.dart';
import '../../../../gen/assets.gen.dart';

class MatchSelectionScreen extends ConsumerStatefulWidget {
  final String tournamentId;

  const MatchSelectionScreen({
    super.key,
    required this.tournamentId,
  });

  @override
  ConsumerState createState() => _MatchSelectionScreenState();
}

class _MatchSelectionScreenState extends ConsumerState<MatchSelectionScreen> {
  late MatchSelectionViewNotifier notifier;

  @override
  void initState() {
    notifier = ref.read(matchSelectionStateProvider.notifier);
    runPostFrame(() => notifier.setData(widget.tournamentId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(matchSelectionStateProvider);

    return AppPage(
      title: context.l10n.match_selection_screen_title,
      actions: [
        _addButton(
          context,
          onPressed: () {
            final option = MatchGroup.values.toList();
            if (state.matches.containsKey(MatchGroup.finals)) {
              option.remove(MatchGroup.finals);
            }

            showActionBottomSheet(
                context: context,
                items: option
                    .map((group) => BottomSheetAction(
                        title: group.getString(context),
                        onTap: () {
                          context.pop();
                          notifier.addGroup(group);
                        }))
                    .toList());
          },
        ),
      ],
      body: Builder(
        builder: (context) => Padding(
          padding: context.mediaQueryPadding,
          child: _body(context, state),
        ),
      ),
    );
  }

  Widget _body(
    BuildContext context,
    MatchSelectionState state,
  ) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: _searchTextField(context, notifier, state),
        ),
        Expanded(
          child: ListView(
            children: state.matches.entries.map((entry) {
              final group = entry.key;
              final roundsMap = entry.value;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: roundsMap.entries.map((roundEntry) {
                  final roundNumber = roundEntry.key;
                  final matches = roundEntry.value;

                  final roundDisplay = group == MatchGroup.finals
                      ? group.getString(context)
                      : "${group.getString(context)} $roundNumber";

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        color: context.colorScheme.containerLow,
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                roundDisplay,
                                style: AppTextStyle.header3.copyWith(
                                  color: context.colorScheme.textPrimary,
                                ),
                              ),
                            ),
                            _addButton(context, onPressed: () {
                              AppRoute.addMatch(
                                tournamentId: state.tournament?.id,
                                group: group,
                                groupNumber: roundNumber,
                              ).push(context);
                            }),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      ...matches
                          .map((match) => _matchCell(context, state, match)),
                    ],
                  );
                }).toList(),
              );
            }).toList(),
          ),
        )
      ],
    );
  }

  Widget _addButton(
    BuildContext context, {
    required VoidCallback onPressed,
  }) {
    return actionButton(
      context,
      onPressed: onPressed,
      icon: Icon(
        CupertinoIcons.add,
        color: context.colorScheme.textPrimary,
        size: 24,
      ),
    );
  }

  Widget _searchTextField(
    BuildContext context,
    MatchSelectionViewNotifier notifier,
    MatchSelectionState state,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SearchTextField(
        controller: state.searchController,
        onChange: notifier.onSearchChanged,
        hintText: context.l10n.search_team_search_placeholder_title,
        suffixIcon: state.searchInProgress
            ? const UnconstrainedBox(child: AppProgressIndicator(radius: 8))
            : const SizedBox(),
      ),
    );
  }

  Widget _matchCell(
    BuildContext context,
    MatchSelectionState state,
    MatchModel match,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      margin: EdgeInsets.only(bottom: 16, left: 16, right: 16),
      decoration: BoxDecoration(
          color: context.colorScheme.containerLowOnSurface,
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          _matchTimeAndGroundView(context, match),
          Divider(color: context.colorScheme.outline),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              children: [
                _overlapProfileView(context, match),
                SizedBox(width: 8),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                        text: match.teams.first.team.name_initial ??
                            match.teams.first.team.name,
                        children: [
                          TextSpan(
                              text:
                                  " ${context.l10n.common_versus_short_title} ",
                              style: AppTextStyle.body1.copyWith(
                                  color: context.colorScheme.textPrimary)),
                          TextSpan(
                              text: match.teams.last.team.name_initial ??
                                  match.teams.last.team.name),
                        ]),
                    style: AppTextStyle.subtitle1
                        .copyWith(color: context.colorScheme.textPrimary),
                  ),
                ),
                _secondaryAddEditButton(context, state, match),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _overlapProfileView(BuildContext context, MatchModel match) {
    return SizedBox(
      width: 70,
      child: Stack(
        children: [
          ImageAvatar(
              initial: match.teams.first.team.name_initial ??
                  match.teams.first.team.name.initials(limit: 1),
              imageUrl: match.teams.first.team.profile_img_url,
              size: 40),
          Positioned(
            left: 30,
            child: ImageAvatar(
                initial: match.teams.last.team.name_initial ??
                    match.teams.last.team.name.initials(limit: 1),
                imageUrl: match.teams.last.team.profile_img_url,
                size: 40),
          ),
        ],
      ),
    );
  }

  Widget _secondaryAddEditButton(
      BuildContext context, MatchSelectionState state, MatchModel match) {
    return OnTapScale(
      onTap: () => match.id.isNotEmpty
          ? AppRoute.addMatch(matchId: match.id).push(context)
          : AppRoute.addMatch(
                  tournamentId: state.tournament?.id,
                  groupNumber: match.match_group_number,
                  group: match.match_group,
                  defaultOpponent: match.teams.last.team,
                  defaultTeam: match.teams.first.team)
              .push(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 22, vertical: 8),
        decoration: BoxDecoration(
          color: context.colorScheme.containerNormal,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          match.id.isEmpty
              ? context.l10n.common_add_title
              : context.l10n.common_edit_title,
          style:
              AppTextStyle.button.copyWith(color: context.colorScheme.primary),
        ),
      ),
    );
  }

  Widget _matchTimeAndGroundView(
    BuildContext context,
    MatchModel match,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Flexible(
          flex: 2,
          child: Text(
              (match.start_at ?? match.start_time ?? DateTime.now())
                  .format(context, DateFormatType.dateAndTime),
              style: AppTextStyle.caption
                  .copyWith(color: context.colorScheme.textDisabled)),
        ),
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SvgPicture.asset(
                Assets.images.icLocation,
                height: 20,
                width: 20,
                colorFilter: ColorFilter.mode(
                  context.colorScheme.textDisabled,
                  BlendMode.srcATop,
                ),
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  match.ground,
                  style: AppTextStyle.caption
                      .copyWith(color: context.colorScheme.textDisabled),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
