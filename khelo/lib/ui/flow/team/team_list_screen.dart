import 'dart:io';

import 'package:data/api/team/team_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/action_bottom_sheet.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/empty_screen.dart';
import 'package:khelo/components/error_screen.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/team/team_list_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/button/action_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';

import '../../../gen/assets.gen.dart';

class TeamListScreen extends ConsumerStatefulWidget {
  const TeamListScreen({super.key});

  @override
  ConsumerState createState() => _TeamListScreenState();
}

class _TeamListScreenState extends ConsumerState<TeamListScreen>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  late TeamListViewNotifier notifier;
  bool _wantKeepAlive = true;

  @override
  bool get wantKeepAlive => _wantKeepAlive;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      setState(() {
        _wantKeepAlive = false;
      });
    } else if (state == AppLifecycleState.resumed) {
      setState(() {
        _wantKeepAlive = true;
      });
    } else if (state == AppLifecycleState.detached) {
      // deallocate resources
      notifier.dispose();
      WidgetsBinding.instance.removeObserver(this);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
        onRetryTap: notifier.onResume,
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
            itemCount: state.filteredTeams.length,
            padding: const EdgeInsets.symmetric(horizontal: 16) +
                context.mediaQueryPadding,
            separatorBuilder: (context, index) =>
                Divider(color: context.colorScheme.outline),
            itemBuilder: (context, index) {
              final team = state.filteredTeams[index];
              return _teamListCell(
                context,
                team: team,
                showMoreOptionButton: state.currentUserId == team.created_by,
              );
            },
          )
        : EmptyScreen(
            title: context.l10n.team_detail_empty_member_title,
            description: context.l10n.team_list_empty_list_description,
            buttonTitle: context.l10n.add_team_screen_title,
            onTap: () => AppRoute.addTeam().push(context),
          );
  }

  Widget _teamListCell(
    BuildContext context, {
    required TeamModel team,
    required bool showMoreOptionButton,
  }) {
    return OnTapScale(
      onTap: () =>
          AppRoute.teamDetail(teamId: team.id ?? "INVALID ID").push(context),
      child: Material(
        type: MaterialType.transparency,
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: ImageAvatar(
            initial: team.name[0].toUpperCase(),
            imageUrl: team.profile_img_url,
            size: 40,
          ),
          title: Text(
            team.name,
            style: AppTextStyle.subtitle2
                .copyWith(color: context.colorScheme.textPrimary),
          ),
          subtitle: team.players != null
              ? Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                      '${team.players!.length} ${context.l10n.add_team_players_text}',
                      style: AppTextStyle.subtitle2
                          .copyWith(color: context.colorScheme.textSecondary)),
                )
              : null,
          trailing: showMoreOptionButton
              ? actionButton(context,
                  onPressed: () => _moreActionButton(context, team),
                  icon: Icon(
                    Platform.isIOS
                        ? Icons.more_horiz_rounded
                        : Icons.more_vert_rounded,
                    color: context.colorScheme.textPrimary,
                  ))
              : null,
        ),
      ),
    );
  }

  void _moreActionButton(
    BuildContext context,
    TeamModel team,
  ) async {
    return await showActionBottomSheet(
        context: context,
        showDragHandle: true,
        items: [
          BottomSheetAction(
            title: context.l10n.team_list_add_members_title,
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
        useRootNavigator: true,
        showDragHandle: true,
        items: TeamFilterOption.values
            .map((option) => BottomSheetAction(
                title: option.getString(context),
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
