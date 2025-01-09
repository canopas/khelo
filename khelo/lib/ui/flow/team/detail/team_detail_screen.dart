import 'dart:io';

import 'package:data/api/team/team_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/action_bottom_sheet.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/error_screen.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/string_extensions.dart';
import 'package:khelo/domain/extensions/widget_extension.dart';
import 'package:khelo/domain/formatter/date_formatter.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/team/detail/components/team_detail_member_content.dart';
import 'package:khelo/ui/flow/team/detail/team_detail_view_model.dart';
import 'package:share_plus/share_plus.dart';
import 'package:style/button/action_button.dart';
import 'package:style/button/more_option_button.dart';
import 'package:style/button/secondary_button.dart';
import 'package:style/button/tab_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';

import '../../../../main.dart';
import 'components/team_detail_match_content.dart';
import 'components/team_detail_stat_content.dart';

class TeamDetailScreen extends ConsumerStatefulWidget {
  final String teamId;
  final bool showAddButton;

  const TeamDetailScreen({
    super.key,
    required this.teamId,
    required this.showAddButton,
  });

  @override
  ConsumerState createState() => _TeamDetailScreenState();
}

class _TeamDetailScreenState extends ConsumerState<TeamDetailScreen> {
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
      actions: [
        if (widget.showAddButton)
          SecondaryButton(
            context.l10n.common_add_title,
            enabled: !state.loading,
            onPressed: () => context.pop(state.team),
          ),
        if (!widget.showAddButton) ...[
          actionButton(
            context,
            icon: Icon(
              Platform.isIOS ? Icons.share : Icons.share_outlined,
              size: 20,
              color: context.colorScheme.textPrimary,
            ),
            onPressed: () =>
                Share.shareUri(Uri.parse("$appBaseUrl/team/${widget.teamId}")),
          ),
          if (state.team?.isAdminOrOwner(state.currentUserId) ?? false)
            moreOptionButton(
              context,
              onPressed: () => _moreActionButton(context, notifier, state),
            ),
        ],
      ],
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
          initial: state.team?.name_initial ??
              state.team?.name.initials(limit: 1) ??
              "?",
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
                (state.team?.created_time ??
                        state.team?.created_at ??
                        DateTime.now())
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
        onRetryTap: notifier.loadData,
      );
    }

    return Padding(
      padding: context.mediaQueryPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          _tabView(context),
          _content(context),
        ],
      ),
    );
  }

  Widget _tabView(BuildContext context) {
    final tabs = [
      context.l10n.team_detail_match_tab_title,
      context.l10n.team_detail_member_tab_title,
      context.l10n.team_detail_stat_tab_title
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(
          tabs.length,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: TabButton(
              tabs[index],
              onTap: () {
                _controller.jumpToPage(index);
              },
              selected: index == _selectedTab,
            ),
          ),
        ),
      ),
    );
  }

  Widget _content(BuildContext context) {
    return Expanded(
      child: PageView(
        controller: _controller,
        onPageChanged: notifier.onTabChange,
        children: const [
          TeamDetailMatchContent(),
          TeamDetailMemberContent(),
          TeamDetailStatContent(),
        ],
      ),
    );
  }

  void _moreActionButton(
    BuildContext context,
    TeamDetailViewNotifier notifier,
    TeamDetailState state,
  ) async {
    return showActionBottomSheet(context: context, items: [
      BottomSheetAction(
        title: context.l10n.common_edit_team_title,
        onTap: () async {
          context.pop();
          AppRoute.addTeam(team: state.team).push(context);
        },
      ),
      BottomSheetAction(
        title: context.l10n.team_detail_add_match_title,
        onTap: () {
          context.pop();
          AppRoute.addMatch(
                  defaultTeam: (state.team?.players.length ?? 0) >= 2
                      ? state.team
                      : null)
              .push(context);
        },
      ),
      if (state.team?.players.isNotEmpty ?? false)
        BottomSheetAction(
          title: context.l10n.common_make_admin,
          child: Text(context.l10n.team_detail_admin(state.team!.players
              .where((element) => element.role == TeamPlayerRole.admin)
              .toList()
              .length)),
          onTap: () {
            context.pop();
            AppRoute.makeTeamAdmin(team: state.team!).push(context);
          },
        ),
      BottomSheetAction(
        title: context.l10n.common_qr_code_title,
        onTap: () {
          context.pop();
          AppRoute.qrCodeView(
                  id: state.team?.id ?? "",
                  description: context.l10n.team_detail_use_qr_description)
              .push(context);
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
