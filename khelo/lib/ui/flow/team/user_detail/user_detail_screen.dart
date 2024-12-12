import 'package:data/api/user/user_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/error_screen.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/widget_extension.dart';
import 'package:khelo/domain/formatter/string_formatter.dart';
import 'package:khelo/ui/flow/team/user_detail/component/user_detail_info_content.dart';
import 'package:khelo/ui/flow/team/user_detail/user_detail_view_model.dart';
import 'package:style/button/action_button.dart';
import 'package:style/button/secondary_button.dart';
import 'package:style/button/tab_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';

import 'component/user_detail_batting_content.dart';
import 'component/user_detail_bowling_content.dart';

class UserDetailScreen extends ConsumerStatefulWidget {
  final String userId;
  final bool showAddButton;

  const UserDetailScreen({
    super.key,
    required this.userId,
    this.showAddButton = false,
  });

  @override
  ConsumerState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends ConsumerState<UserDetailScreen> {
  late PageController _controller;

  int get _selectedTab => _controller.hasClients
      ? _controller.page?.round() ?? 0
      : _controller.initialPage;

  late UserDetailViewNotifier notifier;

  @override
  void initState() {
    super.initState();
    notifier = ref.read(userDetailStateProvider.notifier);
    _controller = PageController(
      initialPage: ref.read(userDetailStateProvider).selectedTab,
    );
    runPostFrame(() => notifier.setUserId(widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userDetailStateProvider);

    return AppPage(
      automaticallyImplyLeading: false,
      padding: const EdgeInsets.symmetric(vertical: 24),
      appBarBackgroundColor: context.colorScheme.containerLow,
      titleWidget: _userProfileView(context, state),
      leading: actionButton(context,
          onPressed: context.pop,
          icon: Icon(
            CupertinoIcons.chevron_back,
            size: 24,
            color: context.colorScheme.textPrimary,
          )),
      actions: (widget.showAddButton)
          ? [
              SecondaryButton(
                context.l10n.common_add_title,
                enabled: !state.loading,
                onPressed: () => context.pop(state.user),
              )
            ]
          : null,
      body: Builder(builder: (context) {
        return _body(context, state);
      }),
    );
  }

  Widget _userProfileView(BuildContext context, UserDetailViewState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ImageAvatar(
          initial: state.user?.nameInitial ?? "?",
          imageUrl: state.user?.profile_img_url,
          size: 48,
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(state.user?.name ?? "",
                style: AppTextStyle.subtitle1
                    .copyWith(color: context.colorScheme.textPrimary)),
            const SizedBox(height: 4),
            Text(
                state.user?.phone
                        .format(context, StringFormats.obscurePhoneNumber) ??
                    '',
                style: AppTextStyle.body2
                    .copyWith(color: context.colorScheme.textSecondary)),
          ],
        ),
      ],
    );
  }

  Widget _body(BuildContext context, UserDetailViewState state) {
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
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _tabView(context),
          _content(context, state),
        ],
      ),
    );
  }

  Widget _tabView(BuildContext context) {
    final tabs = [
      context.l10n.user_detail_info_title,
      context.l10n.common_batting,
      context.l10n.common_bowling
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
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

  Widget _content(BuildContext context, UserDetailViewState state) {
    final testStats = state.userStats
            ?.firstWhere((element) => element.type == UserStatType.test) ??
        UserStat();
    final otherStats = state.userStats
            ?.firstWhere((element) => element.type == UserStatType.other) ??
        UserStat();

    return Expanded(
      child: PageView(
        controller: _controller,
        onPageChanged: notifier.onTabChange,
        children: [
          UserDetailInfoContent(
            teams: state.teams.map((e) => e.name).join(", "),
            user: state.user,
          ),
          UserDetailBattingContent(
            testMatchesCount: testStats.matches,
            otherMatchesCount: otherStats.matches,
            testStats: testStats.batting,
            otherStats: otherStats.batting,
          ),
          UserDetailBowlingContent(
            testMatchesCount: testStats.matches,
            otherMatchesCount: otherStats.matches,
            testStats: testStats.bowling,
            otherStats: otherStats.bowling,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
