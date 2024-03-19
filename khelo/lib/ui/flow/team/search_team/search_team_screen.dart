import 'package:data/api/team/team_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/widget_extension.dart';
import 'package:khelo/ui/flow/team/search_team/components/team_member_dialog.dart';
import 'package:khelo/ui/flow/team/search_team/search_team_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';

class SearchTeamScreen extends ConsumerStatefulWidget {
  final List<String>? excludedIds;

  const SearchTeamScreen({super.key, required this.excludedIds});

  @override
  ConsumerState createState() => _SearchTeamScreenState();
}

class _SearchTeamScreenState extends ConsumerState<SearchTeamScreen> {
  late SearchTeamViewNotifier notifier;

  @override
  void initState() {
    super.initState();
    notifier = ref.read(searchTeamViewStateProvider.notifier);
    runPostFrame(() => notifier.setData(widget.excludedIds));
  }

  @override
  Widget build(BuildContext context) {
    notifier = ref.watch(searchTeamViewStateProvider.notifier);
    final state = ref.watch(searchTeamViewStateProvider);

    return AppPage(
      title: context.l10n.search_team_screen_title,
      actions: [
        IconButton(
            onPressed: state.selectedTeam != null
                ? () async {
                    if (state.userTeams
                        .map((e) => e.id)
                        .contains(state.selectedTeam?.id)) {
                      context.pop(state.selectedTeam);
                    } else {
                      final res = await TeamMemberDialog.show<bool>(
                        context,
                        team: state.selectedTeam!,
                        isForVerification: true,
                      );
                      if (res != null && res && context.mounted) {
                        context.pop(state.selectedTeam);
                      }
                    }
                  }
                : null,
            icon: const Icon(Icons.check)),
      ],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              _searchTextField(context, notifier, state),
              Expanded(
                child: _teamList(context, notifier, state),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchTextField(
    BuildContext context,
    SearchTeamViewNotifier notifier,
    SearchTeamState state,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Material(
        type: MaterialType.transparency,
        child: TextField(
          controller: state.searchController,
          onChanged: notifier.onSearchChanged,
          decoration: InputDecoration(
            hintText: context.l10n.search_team_search_placeholder_title,
            contentPadding: const EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: context.colorScheme.containerLowOnSurface,
            hintStyle: TextStyle(color: context.colorScheme.textDisabled),
            prefixIcon: Icon(
              Icons.search,
              color: context.colorScheme.textDisabled,
              size: 24,
            ),
          ),
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          style: AppTextStyle.body2.copyWith(
            color: context.colorScheme.textPrimary,
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 24,
        ),
        Text(
          title,
          style: AppTextStyle.header1
              .copyWith(color: context.colorScheme.textSecondary),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget _teamList(
    BuildContext context,
    SearchTeamViewNotifier notifier,
    SearchTeamState state,
  ) {
    if (state.loading) {
      return const AppProgressIndicator();
    }
    return ListView(
      children: [
        for (final team in state.searchResults) ...[
          const SizedBox(
            height: 16,
          ),
          _teamProfileCell(context, notifier, state, team)
        ],

        // show team member of current user
        if (state.userTeams.isNotEmpty) ...[
          _sectionTitle(context, context.l10n.search_team_your_teams_title),
          for (final team in state.userTeams) ...[
            _teamProfileCell(context, notifier, state, team),
            const SizedBox(
              height: 16,
            ),
          ],
        ],
      ],
    );
  }

  Widget _teamProfileCell(BuildContext context, SearchTeamViewNotifier notifier,
      SearchTeamState state, TeamModel team) {
    return OnTapScale(
        onTap: () {
          notifier.onTeamCellTap(team);
        },
        onLongTap: () {
          // TODO: show members of team in dialog (play haptic feedback).
          TeamMemberDialog.show<bool>(context, team: team);
        },
        child: Row(
          children: [
            ImageAvatar(
              initial: team.name[0].toUpperCase(),
              imageUrl: team.profile_img_url,
              size: 50,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    team.name,
                    style: AppTextStyle.header4
                        .copyWith(color: context.colorScheme.textPrimary),
                  ),
                  Text.rich(TextSpan(
                      text: team.city != null
                          ? team.city!
                          : context.l10n.common_not_specified_title,
                      style: AppTextStyle.subtitle2
                          .copyWith(color: context.colorScheme.textSecondary),
                      children: [
                        TextSpan(
                            text: " - ${team.players?.length ?? 0} Members")
                      ])),
                ],
              ),
            ),
            if (team.id == state.selectedTeam?.id) ...[
              const Icon(Icons.check_circle_sharp)
            ]
          ],
        ));
  }
}
