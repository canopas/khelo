import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/error_screen.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/string_extensions.dart';
import 'package:khelo/domain/extensions/widget_extension.dart';
import 'package:khelo/domain/formatter/string_formatter.dart';
import 'package:khelo/ui/flow/team/user_detail/component/user_detail_info_content.dart';
import 'package:khelo/ui/flow/team/user_detail/user_detail_view_model.dart';
import 'package:style/button/action_button.dart';
import 'package:style/button/tab_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';

import 'component/user_detail_batting_content.dart';
import 'component/user_detail_bowling_content.dart';

class UserDetailScreen extends ConsumerStatefulWidget {
  final String userId;

  const UserDetailScreen({super.key, required this.userId});

  @override
  ConsumerState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends ConsumerState<UserDetailScreen> {
  final List<Widget> _tabs = [
    const UserDetailInfoContent(),
    const UserDetailBattingContent(),
    const UserDetailBowlingContent(),
  ];

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
          initial: state.user?.name?.initials(limit: 1) ?? "?",
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
              state.user?.phone.format(context, StringFormats.obscurePhoneNumber) ?? '',
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
        children: [
          _tabView(context),
          _content(context),
        ],
      ),
    );
  }

  Widget _tabView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          TabButton(
            context.l10n.user_detail_info_title,
            selected: _selectedTab == 0,
            onTap: () => _controller.jumpToPage(0),
          ),
          const SizedBox(width: 8),
          TabButton(
            context.l10n.user_detail_batting_title,
            selected: _selectedTab == 1,
            onTap: () => _controller.jumpToPage(1),
          ),
          const SizedBox(width: 8),
          TabButton(
            context.l10n.user_detail_bowling_title,
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
}
