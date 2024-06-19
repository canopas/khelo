import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      title: state.team?.name ?? context.l10n.team_detail_screen_title,
      body: _body(context, state),
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

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _teamProfileView(context, state),
        const SizedBox(height: 16),
        _tabView(
          context,
          onAddButtonTap: () => AppRoute.addMatch(
                  defaultTeam: (state.team?.players?.length ?? 0) >= 2
                      ? state.team
                      : null)
              .push(context),
        ),
        _content(context),
      ],
    );
  }

  Widget _teamProfileView(BuildContext context, TeamDetailState state) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: context.colorScheme.containerNormal,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // profile view
          ImageAvatar(
            initial: state.team?.name[0].toUpperCase() ?? "?",
            imageUrl: state.team?.profile_img_url,
            size: 80,
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
      ),
    );
  }

  Widget _tabView(
    BuildContext context, {
    required Function() onAddButtonTap,
  }) {
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
          if (_selectedTab == 0) ...[
            const Spacer(),
            actionButton(context,
                onPressed: onAddButtonTap,
                icon: Icon(
                  Icons.add,
                  color: context.colorScheme.textPrimary,
                )),
          ],
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
