import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/action_bottom_sheet.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/error_screen.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/widget_extension.dart';
import 'package:khelo/domain/formatter/date_formatter.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/team/detail/components/team_detail_member_content.dart';
import 'package:khelo/ui/flow/team/detail/team_detail_view_model.dart';
import 'package:style/button/action_button.dart';
import 'package:style/button/more_option_button.dart';
import 'package:style/button/tab_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';

import 'components/team_detail_match_content.dart';
import 'components/team_detail_stat_content.dart';

class TeamDetailScreen extends ConsumerStatefulWidget {
  final String teamId;

  const TeamDetailScreen({super.key, required this.teamId});

  @override
  ConsumerState createState() => _TeamDetailScreenState();
}

class _TeamDetailScreenState extends ConsumerState<TeamDetailScreen> {
  final List<Widget> _tabs = [
    const TeamDetailMatchContent(),
    const TeamDetailMemberContent(),
    const TeamDetailStatContent(),
  ];

  late PageController _controller;

  late TeamDetailViewNotifier notifier;

  int get _selectedTab => _controller.hasClients
      ? _controller.page?.round() ?? 0
      : _controller.initialPage;

  @override
  void initState() {
    super.initState();
    notifier = ref.read(teamDetailStateProvider.notifier);
    _controller = PageController(
      initialPage: ref.read(teamDetailStateProvider).selectedTab,
    );
    runPostFrame(() => notifier.setData(widget.teamId));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(teamDetailStateProvider);
    return AppPage(
      automaticallyImplyLeading: false,
      padding: const EdgeInsets.symmetric(vertical: 24),
      appBarBackgroundColor: context.colorScheme.containerLow,
      titleWidget: _teamProfileView(context, state),
      leading: actionButton(context,
          onPressed: context.pop,
          icon: Icon(
            CupertinoIcons.chevron_back,
            size: 24,
            color: context.colorScheme.textPrimary,
          )),
      actions: (state.currentUserId == state.team?.created_by)
          ? [
              moreOptionButton(
                context,
                onPressed: () => _moreActionButton(context, notifier, state),
              ),
            ]
          : null,
      body: Builder(builder: (context) {
        return _body(context, state);
      }),
    );
  }

  Widget _teamProfileView(BuildContext context, TeamDetailState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // profile view
        ImageAvatar(
          initial: state.team?.name[0].toUpperCase() ?? "?",
          imageUrl: state.team?.profile_img_url,
          size: 48,
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(state.team?.name ?? "",
                style: AppTextStyle.subtitle1
                    .copyWith(color: context.colorScheme.textPrimary)),
            const SizedBox(height: 4),
            Text(
                (state.team?.created_at ?? DateTime.now())
                    .format(context, DateFormatType.dayMonthYear),
                style: AppTextStyle.body2
                    .copyWith(color: context.colorScheme.textSecondary)),
          ],
        ),
      ],
    );
  }

  Widget _body(BuildContext context, TeamDetailState state) {
    if (state.loading) {
      return const Center(child: AppProgressIndicator());
    }
    if (state.error != null) {
      return ErrorScreen(
        error: state.error,
        onRetryTap: notifier.loadTeamById,
      );
    }

    return Padding(
      padding: context.mediaQueryPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          _tabView(context),
          const SizedBox(height: 16),
          _content(context),
        ],
      ),
    );
  }

  Widget _tabView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          TabButton(
            context.l10n.team_detail_match_tab_title,
            selected: _selectedTab == 0,
            onTap: () => _controller.jumpToPage(0),
          ),
          const SizedBox(width: 8),
          TabButton(
            context.l10n.team_detail_member_tab_title,
            selected: _selectedTab == 1,
            onTap: () => _controller.jumpToPage(1),
          ),
          const SizedBox(width: 8),
          TabButton(
            context.l10n.team_detail_stat_tab_title,
            selected: _selectedTab == 2,
            onTap: () => _controller.jumpToPage(2),
          ),
        ],
      ),
    );
  }

  Widget _content(BuildContext context) {
    return Expanded(
      child: PageView(
        controller: _controller,
        children: _tabs,
        onPageChanged: (index) {
          notifier.onTabChange(index);
          setState(() {});
        },
      ),
    );
  }

  void _moreActionButton(
    BuildContext context,
    TeamDetailViewNotifier notifier,
    TeamDetailState state,
  ) async {
    return showActionBottomSheet(
        context: context,
        showDragHandle: true,
        items: [
          BottomSheetAction(
            title: context.l10n.common_edit_team_title,
            onTap: () async {
              context.pop();
              bool? isUpdated =
                  await AppRoute.addTeam(team: state.team).push<bool>(context);
              if (isUpdated == true && context.mounted) {
                notifier.loadTeamById();
              }
            },
          ),
          BottomSheetAction(
            title: context.l10n.add_match_screen_title,
            onTap: () async {
              context.pop();
              bool? isUpdated = await AppRoute.addMatch(
                      defaultTeam: (state.team?.players?.length ?? 0) >= 2
                          ? state.team
                          : null)
                  .push<bool>(context);
              if (isUpdated == true && context.mounted) {
                notifier.loadTeamById();
              }
            },
          ),
        ]);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
