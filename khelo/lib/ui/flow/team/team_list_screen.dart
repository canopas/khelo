import 'package:data/api/team/team_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/team/team_list_view_model.dart';
import 'package:style/button/large_icon_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';

class TeamListScreen extends ConsumerWidget {
  const TeamListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(teamListViewStateProvider.notifier);
    final state = ref.watch(teamListViewStateProvider);

    return _teamList(context, notifier, state);
  }

  Widget _teamList(BuildContext context, TeamListViewNotifier notifier,
      TeamListViewState state) {
    if (state.loading) {
      return const Center(child: AppProgressIndicator());
    }

    return Stack(
      children: [
        ListView.separated(
          padding: context.mediaQueryPadding +
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          itemBuilder: (context, index) {
            final team = state.teams[index];

            return _teamListCell(context, notifier, team);
          },
          itemCount: state.teams.length,
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 16,
            );
          },
        ),
        _floatingAddButton(context, notifier),
      ],
    );
  }

  Widget _teamListCell(
      BuildContext context, TeamListViewNotifier notifier, TeamModel team) {
    return Row(
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
              Text(team.city ?? context.l10n.common_not_specified_title,
                  style: AppTextStyle.subtitle2
                      .copyWith(color: context.colorScheme.textSecondary)),
            ],
          ),
        ),
        PopupMenuButton<String>(
          color: context.colorScheme.containerNormalOnSurface,
          iconColor: context.colorScheme.textPrimary,
          onSelected: (value) async {
            if (value == context.l10n.team_list_add_members_title) {
              await AppRoute.addTeamMember(team: team).push(context);
            } else if (value == context.l10n.team_list_edit_team_title) {
              await AppRoute.addTeam(team: team).push(context);
            }
            notifier.loadTeamList();
          },
          itemBuilder: (BuildContext context) {
            return {
              context.l10n.team_list_add_members_title,
              context.l10n.team_list_edit_team_title
            }.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(
                  choice,
                  style: AppTextStyle.subtitle1
                      .copyWith(color: context.colorScheme.textPrimary),
                ),
              );
            }).toList();
          },
        ),
      ],
    );
  }

  Widget _floatingAddButton(
    BuildContext context,
    TeamListViewNotifier notifier,
  ) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
        child: LargeIconButton(
          backgroundColor: context.colorScheme.primary,
          onTap: () async {
            await AppRoute.addTeam().push(context);
            notifier.loadTeamList();
          },
          icon: Icon(
            Icons.add_rounded,
            color: context.colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
