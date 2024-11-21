import 'package:data/api/team/team_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/error_screen.dart';
import 'package:khelo/components/error_snackbar.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/string_extensions.dart';
import 'package:khelo/domain/extensions/widget_extension.dart';
import 'package:khelo/ui/flow/team/search_team/components/team_member_sheet.dart';
import 'package:khelo/ui/flow/team/search_team/search_team_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/button/action_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';
import 'package:style/text/search_text_field.dart';
import 'package:style/widgets/rounded_check_box.dart';

import '../../../../components/create_team_cell.dart';
import '../../../../gen/assets.gen.dart';
import '../../../app_route.dart';
import '../scanner/scanner_view_model.dart';

class SearchTeamScreen extends ConsumerStatefulWidget {
  final List<String>? excludedIds;
  final bool onlyUserTeams;
  final String? tournamentId;

  const SearchTeamScreen({
    super.key,
    required this.excludedIds,
    required this.onlyUserTeams,
    this.tournamentId,
  });

  @override
  ConsumerState createState() => _SearchTeamScreenState();
}

class _SearchTeamScreenState extends ConsumerState<SearchTeamScreen> {
  late SearchTeamViewNotifier notifier;

  @override
  void initState() {
    super.initState();
    notifier = ref.read(searchTeamViewStateProvider.notifier);
    runPostFrame(() => notifier.setData(
        widget.excludedIds, widget.onlyUserTeams, widget.tournamentId));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchTeamViewStateProvider);
    _observeActionError();

    return AppPage(
      title: context.l10n.search_team_screen_title,
      actions: [
        actionButton(
          context,
          onPressed: () async {
            final team = await AppRoute.scannerScreen(
              target: ScanTarget.team,
              addedIds: widget.excludedIds ?? [],
            ).push<TeamModel>(context);
            if (context.mounted && team != null) notifier.onTeamCellTap(team);
          },
          icon: SvgPicture.asset(
            Assets.images.icQrCode,
            colorFilter: ColorFilter.mode(
              context.colorScheme.textPrimary,
              BlendMode.srcIn,
            ),
          ),
        ),
        actionButton(
          context,
          onPressed: state.selectedTeam != null
              ? () => _handleSaveAction(context, state)
              : null,
          icon: SvgPicture.asset(
            Assets.images.icCheck,
            colorFilter: ColorFilter.mode(
              state.selectedTeam != null
                  ? context.colorScheme.textPrimary
                  : context.colorScheme.textDisabled,
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              _searchTextField(context, state),
              Expanded(child: _teamList(context, state)),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleSaveAction(
    BuildContext context,
    SearchTeamState state,
  ) async {
    if (state.userTeams.any((team) => team.id == state.selectedTeam?.id) ||
        (state.tournament?.team_ids
                .any((element) => element == state.selectedTeam?.id) ??
            false)) {
      await notifier.addTeamToTournamentIfNeeded();
      if (context.mounted) {
        context.pop(state.selectedTeam);
      }
    } else {
      final res = await TeamMemberSheet.show<bool>(
        context,
        team: state.selectedTeam!,
        isForVerification: true,
      );
      await notifier.addTeamToTournamentIfNeeded();
      if (res != null && res && context.mounted) {
        context.pop(state.selectedTeam);
      }
    }
  }

  Widget _searchTextField(
    BuildContext context,
    SearchTeamState state,
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

  Widget _teamList(
    BuildContext context,
    SearchTeamState state,
  ) {
    if (state.loading) {
      return const Center(child: AppProgressIndicator());
    }

    if (state.error != null) {
      return ErrorScreen(
        error: state.error,
        onRetryTap: notifier.onSearchChanged,
      );
    }

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      children: [
        for (int index = 0; index < state.searchResults.length; index++) ...[
          _teamProfileCell(context, state, state.searchResults[index]),
          if (index != state.searchResults.length - 1)
            Divider(color: context.colorScheme.outline),
        ],
        const SizedBox(height: 16),
        Text(
          context.l10n.common_your_teams_title,
          style: AppTextStyle.header2
              .copyWith(color: context.colorScheme.textSecondary),
        ),
        const SizedBox(height: 8),
        for (int index = 0; index < state.userTeams.length; index++) ...[
          _teamProfileCell(context, state, state.userTeams[index]),
          if (index != state.userTeams.length - 1) ...[
            Divider(color: context.colorScheme.outline),
          ] else ...[
            const SizedBox(height: 8),
          ],
        ],
        const SizedBox(height: 8),
        createTeamCell(context)
      ],
    );
  }

  Widget _teamProfileCell(
    BuildContext context,
    SearchTeamState state,
    TeamModel team,
  ) {
    return OnTapScale(
      onTap: () => notifier.onTeamCellTap(team),
      onLongTap: () => TeamMemberSheet.show<bool>(context, team: team),
      child: Material(
        type: MaterialType.transparency,
        child: ListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          leading: ImageAvatar(
            initial: team.name_initial ?? team.name.initials(limit: 1),
            imageUrl: team.profile_img_url,
            size: 40,
          ),
          title: Text(
            team.name,
            style: AppTextStyle.subtitle2
                .copyWith(color: context.colorScheme.textPrimary),
          ),
          subtitle: Text.rich(
            TextSpan(
              text: team.city != null
                  ? team.city!
                  : context.l10n.common_not_specified_title,
              style: AppTextStyle.body2
                  .copyWith(color: context.colorScheme.textSecondary),
              children: [
                WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      constraints:
                          const BoxConstraints(maxHeight: 4, maxWidth: 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.colorScheme.textDisabled,
                      ),
                    )),
                TextSpan(
                  text: context.l10n.common_players_title(
                      team.players.where((e) => e.user.isActive).length),
                ),
              ],
            ),
          ),
          trailing: (team.id == state.selectedTeam?.id)
              ? RoundedCheckBox(isSelected: true, onTap: null)
              : null,
        ),
      ),
    );
  }

  void _observeActionError() {
    ref.listen(
      searchTeamViewStateProvider.select((value) => value.showSelectionError),
      (previous, next) {
        if (next) {
          showErrorSnackBar(
              context: context,
              error: context.l10n.search_team_selection_error_text);
        }
      },
    );
  }
}
