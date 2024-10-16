import 'package:data/api/team/team_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/string_extensions.dart';
import 'package:khelo/ui/flow/tournament/team_selection/team_selection_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';
import 'package:style/text/search_text_field.dart';
import 'package:style/widgets/rounded_check_box.dart';

import '../../../../components/create_team_cell.dart';
import '../../../../components/error_screen.dart';
import '../../../../components/error_snackbar.dart';
import '../../../../components/image_avatar.dart';
import '../../../../domain/extensions/widget_extension.dart';
import '../../../../gen/assets.gen.dart';
import '../../team/search_team/components/team_member_sheet.dart';

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
        IconButton(
          onPressed: () async {
            final userTeams = state.userTeams.map((e) => e.id).toSet();
            final previouslySelected =
                notifier.selectedIds.map((e) => e.id).toSet();
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

            for (final team in unverified) {
              final res = await TeamMemberSheet.show<bool>(
                context,
                team: team,
                isForVerification: true,
              );

              if (res == true && context.mounted) {
                verified.add(team);
              }
            }

            if (context.mounted) {
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
        for (int index = 0; index < state.searchResults.length; index++) ...[
          _teamProfileCell(context, state, state.searchResults[index]),
          if (index != state.searchResults.length - 1)
            Divider(color: context.colorScheme.outline),
        ],
        for (int index = 0; index < selectedTeam.length; index++) ...[
          if (state.searchResults.isNotEmpty)
            Divider(color: context.colorScheme.outline),
          _teamProfileCell(context, state, selectedTeam[index]),
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
      BuildContext context, TeamSelectionViewState state, TeamModel team) {
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
                  text: context.l10n.common_players_title(team.players.length),
                ),
              ],
            ),
          ),
          trailing: RoundedCheckBox(
              isSelected:
                  state.selectedTeams.map((e) => e.id).contains(team.id),
              onTap: (_) => notifier.onTeamCellTap(team)),
        ),
      ),
    );
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
