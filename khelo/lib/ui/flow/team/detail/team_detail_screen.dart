import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/widget_extension.dart';
import 'package:khelo/ui/flow/team/detail/components/team_detail_member_content.dart';
import 'package:khelo/ui/flow/team/detail/team_detail_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
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
    const TeamDetailMemberContent(),
    const TeamDetailMatchContent(),
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
    notifier = ref.watch(teamDetailStateProvider.notifier);
    final state = ref.watch(teamDetailStateProvider);

    return AppPage(
      title: state.team?.name ?? context.l10n.team_detail_screen_title,
      body: _body(context, state),
    );
  }

  Widget _body(BuildContext context, TeamDetailState state) {
    if (state.loading) {
      return const Center(
        child: AppProgressIndicator(),
      );
    }
    return Padding(
      padding: context.mediaQueryPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _teamProfileView(context, state),
          _tabView(context),
          _content(context),
        ],
      ),
    );
  }

  Widget _teamProfileView(BuildContext context, TeamDetailState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // profile view
              ImageAvatar(
                initial: state.team?.name[0].toUpperCase() ?? "?",
                imageUrl: state.team?.profile_img_url,
                size: 90,
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(state.team?.name ?? "",
                      style: AppTextStyle.header4
                          .copyWith(color: context.colorScheme.textPrimary)),
                  Text(state.team?.city ?? "",
                      style: AppTextStyle.subtitle2
                          .copyWith(color: context.colorScheme.textPrimary)),
                  Text(
                      DateFormat.yMMMd()
                          .format(state.team?.created_at ?? DateTime.now()),
                      style: AppTextStyle.subtitle2
                          .copyWith(color: context.colorScheme.textPrimary)),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          const Divider(),
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

  Widget _tabView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _tabButton(
            context.l10n.team_detail_member_tab_title,
            _selectedTab == 0,
            onTap: () {
              _controller.jumpToPage(0);
            },
          ),
          const SizedBox(width: 8),
          _tabButton(
            context.l10n.team_detail_match_tab_title,
            _selectedTab == 1,
            onTap: () {
              _controller.jumpToPage(1);
            },
          ),
          const SizedBox(width: 8),
          _tabButton(
            context.l10n.team_detail_stat_tab_title,
            _selectedTab == 2,
            onTap: () {
              _controller.jumpToPage(2);
            },
          ),
        ],
      ),
    );
  }

  Widget _tabButton(String title, bool selected, {VoidCallback? onTap}) {
    return OnTapScale(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? context.colorScheme.primary
              : context.colorScheme.containerLow,
          borderRadius: BorderRadius.circular(56),
        ),
        child: Text(
          title,
          style: AppTextStyle.body2.copyWith(
            color: selected
                ? context.colorScheme.onPrimary
                : context.colorScheme.textSecondary,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
