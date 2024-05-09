import 'package:data/api/team/team_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/error_screen.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/components/resume_detector.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/team/components/select_filter_option_sheet.dart';
import 'package:khelo/ui/flow/team/team_list_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/button/large_icon_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';

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

  void _observeShowFilterOptionSheet(
    BuildContext context,
    WidgetRef ref,
  ) {
    ref.listen(
        teamListViewStateProvider
            .select((value) => value.showFilterOptionSheet), (previous, next) {
      SelectFilterOptionSheet.show(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    notifier = ref.watch(teamListViewStateProvider.notifier);
    final state = ref.watch(teamListViewStateProvider);

    _observeShowFilterOptionSheet(context, ref);
    return ResumeDetector(
        onResume: notifier.onResume,
        child: _teamList(context, notifier, state));
  }

  Widget _teamList(
    BuildContext context,
    TeamListViewNotifier notifier,
    TeamListViewState state,
  ) {
    if (state.loading) {
      return const Center(child: AppProgressIndicator());
    }
    if (state.error != null) {
      return ErrorScreen(
        error: state.error,
        onRetryTap: notifier.onResume,
      );
    }

    return Stack(
      children: [
        ListView.separated(
          itemCount: state.filteredTeams.length,
          padding: context.mediaQueryPadding +
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 60),
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final team = state.filteredTeams[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (index == 0) ...[
                  Text(
                    state.selectedFilter.getString(context),
                    style: AppTextStyle.subtitle1.copyWith(
                        color: context.colorScheme.textPrimary, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 16,
                  )
                ],
                _teamListCell(
                  context,
                  notifier,
                  team,
                  showMoreOptionButton: state.currentUserId == team.created_by,
                ),
              ],
            );
          },
        ),
        _floatingAddButton(context, notifier),
      ],
    );
  }

  Widget _teamListCell(
    BuildContext context,
    TeamListViewNotifier notifier,
    TeamModel team, {
    required bool showMoreOptionButton,
  }) {
    return OnTapScale(
      onTap: () {
        AppRoute.teamDetail(teamId: team.id ?? "INVALID ID").push(context);
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
                Text(team.city ?? context.l10n.common_not_specified_title,
                    style: AppTextStyle.subtitle2
                        .copyWith(color: context.colorScheme.textSecondary)),
              ],
            ),
          ),
          if (showMoreOptionButton) ...[
            _moreActionButton(
              context,
              onSelect: (value) async {
                if (value == context.l10n.team_list_add_members_title) {
                  await AppRoute.addTeamMember(team: team).push(context);
                } else if (value == context.l10n.team_list_edit_team_title) {
                  await AppRoute.addTeam(team: team).push(context);
                }
              },
            )
          ]
        ],
      ),
    );
  }

  Widget _moreActionButton(
    BuildContext context, {
    required Function(String) onSelect,
  }) {
    return PopupMenuButton<String>(
      color: context.colorScheme.containerNormalOnSurface,
      iconColor: context.colorScheme.textPrimary,
      onSelected: (value) => onSelect(value),
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
