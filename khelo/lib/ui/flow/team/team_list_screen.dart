import 'package:data/api/team/team_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/action_bottom_sheet.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/empty_screen.dart';
import 'package:khelo/components/error_screen.dart';
import 'package:khelo/components/team_detail_cell.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/team/team_list_view_model.dart';
import 'package:style/callback/on_visible_callback.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';

import '../../../domain/extensions/widget_extension.dart';
import '../../../gen/assets.gen.dart';

class TeamListScreen extends ConsumerStatefulWidget {
  const TeamListScreen({super.key});

  @override
  ConsumerState createState() => _TeamListScreenState();
}

class _TeamListScreenState extends ConsumerState<TeamListScreen>
    with WidgetsBindingObserver {
  late TeamListViewNotifier notifier;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      // deallocate resources
      notifier.dispose();
      WidgetsBinding.instance.removeObserver(this);
    }
  }

  @override
  Widget build(BuildContext context) {
    notifier = ref.watch(teamListViewStateProvider.notifier);
    _observeShowFilterOptionSheet(context, ref);

    return AppPage(
      body: Builder(builder: (context) {
        return _body(context);
      }),
    );
  }

  Widget _body(BuildContext context) {
    final state = ref.watch(teamListViewStateProvider);
    if (state.loading) {
      return const Center(child: AppProgressIndicator());
    }
    if (state.error != null) {
      return ErrorScreen(
        error: state.error,
        onRetryTap: notifier.loadTeamList,
      );
    }

    return _teamList(context, state);
  }

  Widget _teamList(
    BuildContext context,
    TeamListViewState state,
  ) {
    return (state.filteredTeams.isNotEmpty)
        ? ListView.separated(
            itemCount: state.filteredTeams.length + 1,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8) +
                context.mediaQueryPadding,
            separatorBuilder: (context, index) =>
                Divider(color: context.colorScheme.outline),
            itemBuilder: (context, index) {
              if (index < state.filteredTeams.length) {
                final team = state.filteredTeams[index];
                return TeamDetailCell(
                  team: team,
                  showMoreOptionButton:
                      team.isAdminOrOwner(state.currentUserId),
                  onTap: () =>
                      AppRoute.teamDetail(teamId: team.id).push(context),
                  onMoreOptionTap: () => _moreActionButton(context, team),
                );
              }
              return OnVisibleCallback(
                onVisible: () => runPostFrame(notifier.loadTeamList),
                child: (state.loading && state.teams.isNotEmpty)
                    ? const Center(child: AppProgressIndicator())
                    : const SizedBox(),
              );
            },
          )
        : EmptyScreen(
            title: context.l10n.team_list_no_teams_created_title,
            description: context.l10n.team_list_empty_list_description,
            isShowButton: false,
          );
  }

  void _moreActionButton(
    BuildContext context,
    TeamModel team,
  ) async {
    return await showActionBottomSheet(context: context, items: [
      BottomSheetAction(
        title: context.l10n.team_detail_add_members_title,
        onTap: () {
          context.pop();
          AppRoute.addTeamMember(team: team).push(context);
        },
      ),
      BottomSheetAction(
        title: context.l10n.common_edit_team_title,
        onTap: () {
          context.pop();
          AppRoute.addTeam(team: team).push(context);
        },
      ),
    ]);
  }

  void _filterActionSheet(
      BuildContext context, TeamFilterOption selectedFilter) async {
    return await showActionBottomSheet(
        context: context,
        items: TeamFilterOption.values
            .map((option) => BottomSheetAction(
                title: option.getString(context),
                enabled: selectedFilter != option,
                child: selectedFilter == option
                    ? SvgPicture.asset(
                        Assets.images.icCheck,
                        colorFilter: ColorFilter.mode(
                          context.colorScheme.primary,
                          BlendMode.srcATop,
                        ),
                      )
                    : null,
                onTap: () {
                  context.pop();
                  notifier.onFilterOptionSelect(option);
                }))
            .toList());
  }

  void _observeShowFilterOptionSheet(
    BuildContext context,
    WidgetRef ref,
  ) {
    ref.listen(
        teamListViewStateProvider
            .select((value) => value.showFilterOptionSheet), (previous, next) {
      if (next != null) {
        final selectedFilter = ref.watch(
            teamListViewStateProvider.select((value) => value.selectedFilter));
        _filterActionSheet(context, selectedFilter);
      }
    });
  }
}
