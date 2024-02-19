import 'package:data/api/user/user_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/widget_extension.dart';
import 'package:khelo/ui/flow/matches/add_match/match_officials/components/search_user_screen.dart';
import 'package:style/animations/on_tap_scale.dart';
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
    notifier = ref.watch(addMatchOfficialsStateProvider.notifier);
    final state = ref.watch(addMatchOfficialsStateProvider);

    return AppPage(
      title: context.l10n.add_match_officials_screen_title,
      body: Stack(
        children: [
          ListView(
            padding: context.mediaQueryPadding +
                const EdgeInsets.symmetric(horizontal: 16) +
                BottomStickyOverlay.padding,
            children: [
              for (final type in MatchOfficials.values) ...[
                _sectionTitle(context, type.getTitle(context)),
                _officialList(context, notifier, state, type),
              ],
              const SizedBox(
                height: 40,
              )
            ],
          ),
          _stickyButton(context, state)
        ],
      ),
    );
  }

  List<UserModel> _getFilteredUser(
      AddMatchOfficialsState state, MatchOfficials type) {
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
          const SizedBox(
            height: 24,
          ),
          Text(
            title,
            style: AppTextStyle.header1
                .copyWith(color: context.colorScheme.textSecondary),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  Widget _officialList(
      BuildContext context,
      AddMatchOfficialsViewNotifier notifier,
      AddMatchOfficialsState state,
      MatchOfficials type) {
    final users = _getFilteredUser(state, type);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < type.count; i++) ...[
            if (i != 0)
              const SizedBox(
                width: 16,
              ),
            _officialsCell(
              context: context,
              image: type.getImagePath(),
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

  Widget _officialsCell({
    required BuildContext context,
    required String image,
    UserModel? user,
    required Function() onCardTap,
    required Function() onRemoveTap,
  }) {
    return OnTapScale(
      onTap: () => onCardTap(),
      child: Container(
        height: 180,
        width: 150,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: context.colorScheme.containerLowOnSurface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: context.colorScheme.containerNormalOnSurface)),
        child: user == null
            ? Image.asset(
                image,
                fit: BoxFit.contain,
                color: context.colorScheme.textDisabled,
              )
            : Column(
                children: [
                  ImageAvatar(
                    initial: user.nameInitial,
                    imageUrl: user.profile_img_url,
                    size: 90,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user.name ?? "",
                    style: AppTextStyle.header4
                        .copyWith(color: context.colorScheme.textSecondary),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 8),
                  OnTapScale(
                      onTap: () => onRemoveTap(),
                      child: Text(
                        context.l10n.common_remove_title,
                        style: AppTextStyle.button
                            .copyWith(color: context.colorScheme.alert),
                      )),
                ],
              ),
      ),
    );
  }

  Widget _stickyButton(BuildContext context, AddMatchOfficialsState state) {
    return BottomStickyOverlay(
      child: PrimaryButton(
        context.l10n.add_match_officials_add_officials_title,
        enabled: true,
        progress: false,
        onPressed: () {
          context.pop(state.officials);
        },
      ),
    );
  }
}
