import 'package:data/api/team/team_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/tournament/team_selection/component/verification_team_list_sheet.dart';
import 'package:khelo/ui/flow/tournament/team_selection/team_selection_view_model.dart';
import 'package:style/button/action_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';
import 'package:style/text/search_text_field.dart';
import 'package:style/widgets/rounded_check_box.dart';

import '../../../../components/create_team_cell.dart';
import '../../../../components/error_screen.dart';
import '../../../../components/error_snackbar.dart';
import '../../../../domain/extensions/widget_extension.dart';
import '../../../../gen/assets.gen.dart';
import '../../../app_route.dart';
import '../../team/scanner/scanner_view_model.dart';
import '../../team/search_team/components/team_member_sheet.dart';
import 'component/team_profile_cell.dart';

class TeamSelectionScreen extends ConsumerStatefulWidget {
  final List<TeamModel>? selectedTeams;

  const TeamSelectionScreen({
    super.key,
    this.selectedTeams,
  });

  @override
  ConsumerState createState() => _TeamSelectionScreenState();
}

class _TeamSelectionScreenState extends ConsumerState<TeamSelectionScreen> {
  late TeamSelectionViewNotifier notifier;

  @override
  void initState() {
    super.initState();
    notifier = ref.read(teamSelectionViewStateProvider.notifier);
    runPostFrame(() => notifier.setData(widget.selectedTeams));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(teamSelectionViewStateProvider);
    _observeActionError();

    return AppPage(
      title: context.l10n.team_selection_screen_title,
      actions: [
        actionButton(
          context,
          onPressed: () async {
            final team = await AppRoute.scannerScreen(
              target: ScanTarget.team,
              addedIds: widget.selectedTeams?.map((e) => e.id).toList() ?? [],
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
          onPressed: () async {
            final userTeams = state.userTeams.map((e) => e.id).toSet();
            final previouslySelected = notifier.selectedIds.toSet();
            final List<TeamModel> verified = [];
            final List<TeamModel> unverified = [];

            for (final team in state.selectedTeams) {
              if (userTeams.contains(team.id) ||
                  previouslySelected.contains(team.id)) {
                verified.add(team);
              } else {
                unverified.add(team);
              }
            }

            if (unverified.isNotEmpty) {
              final list =
                  await VerificationTeamListSheet.show<List<TeamModel>>(
                context,
                verified: verified,
                allTeams: state.selectedTeams,
              );
              if (context.mounted && list != null) context.pop(list);
            } else if (context.mounted) {
              context.pop(verified);
            }
          },
          icon: SvgPicture.asset(
            Assets.images.icCheck,
            colorFilter: ColorFilter.mode(
              context.colorScheme.textPrimary,
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

  Widget _searchTextField(BuildContext context, TeamSelectionViewState state) {
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

  Widget _teamList(BuildContext context, TeamSelectionViewState state) {
    if (state.loading) {
      return const Center(child: AppProgressIndicator());
    }

    if (state.error != null) {
      return ErrorScreen(
        error: state.error,
        onRetryTap: notifier.onSearchChanged,
      );
    }

    final selectedTeam = notifier.getSelectedTeamOfOtherUser();

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      children: [
        ..._buildTeamList(state,
            teams: state.searchResults,
            showDividerAtLast: selectedTeam.isNotEmpty),
        ..._buildTeamList(state, teams: selectedTeam),
        const SizedBox(height: 16),
        Text(
          context.l10n.common_your_teams_title,
          style: AppTextStyle.header2
              .copyWith(color: context.colorScheme.textSecondary),
        ),
        const SizedBox(height: 8),
        ..._buildTeamList(state, teams: state.userTeams),
        SizedBox(height: state.userTeams.isEmpty ? 8 : 16),
        createTeamCell(context)
      ],
    );
  }

  List<Widget> _buildTeamList(
    TeamSelectionViewState state, {
    required List<TeamModel> teams,
    bool showDividerAtLast = false,
  }) {
    if (teams.isEmpty) {
      return [];
    }
    final listLength = (teams.length * 2) - (showDividerAtLast ? 0 : 1);
    return List.generate(listLength, (index) {
      if (index.isOdd) {
        return Divider(color: context.colorScheme.outline);
      } else {
        final team = teams[index ~/ 2];
        return TeamProfileCell(
          team: team,
          onTap: () => notifier.onTeamCellTap(team),
          onLongTap: () => TeamMemberSheet.show<bool>(context, team: team),
          trailing: RoundedCheckBox(
              isSelected:
                  state.selectedTeams.map((e) => e.id).contains(team.id),
              onTap: (_) => notifier.onTeamCellTap(team)),
        );
      }
    });
  }

  void _observeActionError() {
    ref.listen(
      teamSelectionViewStateProvider
          .select((value) => value.showSelectionError),
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
