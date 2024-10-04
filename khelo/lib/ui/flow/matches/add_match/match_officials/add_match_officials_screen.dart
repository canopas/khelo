import 'package:data/api/user/user_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/widget_extension.dart';
import 'package:khelo/ui/flow/matches/add_match/match_officials/components/officials_cell_view.dart';
import 'package:khelo/ui/flow/matches/add_match/match_officials/search_user/search_user_screen.dart';
import 'package:style/button/back_button.dart';
import 'package:style/button/bottom_sticky_overlay.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

import 'add_match_officials_view_model.dart';

class AddMatchOfficialsScreen extends ConsumerStatefulWidget {
  final List<Officials>? officials;

  const AddMatchOfficialsScreen({super.key, this.officials});

  @override
  ConsumerState createState() => _AddMatchOfficialsScreenState();
}

class _AddMatchOfficialsScreenState
    extends ConsumerState<AddMatchOfficialsScreen> {
  late AddMatchOfficialsViewNotifier notifier;

  @override
  void initState() {
    super.initState();
    notifier = ref.read(addMatchOfficialsStateProvider.notifier);
    runPostFrame(() => notifier.setData(widget.officials ?? []));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addMatchOfficialsStateProvider);

    return AppPage(
      title: context.l10n.add_match_officials_screen_title,
      leading: backButton(context, onPressed: context.pop),
      body: Builder(builder: (context) {
        return Stack(
          children: [
            ListView(
              padding: context.mediaQueryPadding +
                  BottomStickyOverlay.padding +
                  const EdgeInsets.only(bottom: 40),
              children: [
                for (final type in MatchOfficials.values) ...[
                  _sectionTitle(context, type.getTitle(context)),
                  _officialList(context, notifier, state, type),
                ],
              ],
            ),
            _stickyButton(context, state)
          ],
        );
      }),
    );
  }

  List<UserModel> _getFilteredUser(
    AddMatchOfficialsState state,
    MatchOfficials type,
  ) {
    return state.officials
        .where((element) => element.type == type)
        .map((e) => e.user)
        .toList();
  }

  Widget _sectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Text(
            title,
            style: AppTextStyle.header4
                .copyWith(color: context.colorScheme.textPrimary),
          ),
        ],
      ),
    );
  }

  Widget _officialList(
    BuildContext context,
    AddMatchOfficialsViewNotifier notifier,
    AddMatchOfficialsState state,
    MatchOfficials type,
  ) {
    final users = _getFilteredUser(state, type);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < type.count; i++) ...[
            OfficialsCellView(
              type: type,
              user: users.elementAtOrNull(i),
              onCardTap: () async {
                final existingUser = users.elementAtOrNull(i);
                final user =
                    await SearchUserBottomSheet.show<UserModel>(context);
                if (user != null && context.mounted) {
                  if (existingUser != null) {
                    notifier.updateOfficial(type, existingUser.id, user);
                  } else {
                    notifier.addOfficial(type, user);
                  }
                }
              },
              onRemoveTap: () {
                final user = users.elementAtOrNull(i);
                if (user != null) {
                  notifier.removeOfficial(type, user);
                }
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _stickyButton(BuildContext context, AddMatchOfficialsState state) {
    return BottomStickyOverlay(
      child: PrimaryButton(
        context.l10n.add_match_officials_add_officials_title,
        enabled: true,
        progress: false,
        onPressed: () => context.pop(state.officials),
      ),
    );
  }
}
