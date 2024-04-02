import 'package:data/api/match/match_model.dart';
import 'package:data/api/team/team_model.dart';
import 'package:data/api/user/user_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/domain/extensions/widget_extension.dart';
import 'package:khelo/domain/formatter/string_formatter.dart';
import 'package:khelo/ui/flow/matches/add_match/select_squad/components/select_admin_and_captain_dialog.dart';
import 'package:khelo/ui/flow/matches/add_match/select_squad/components/user_detail_sheet.dart';
import 'package:khelo/ui/flow/matches/add_match/select_squad/select_squad_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class SelectSquadScreen extends ConsumerStatefulWidget {
  final TeamModel team;
  final List<MatchPlayer>? squad;
  final String? captainId;
  final String? adminId;

  const SelectSquadScreen({
    super.key,
    required this.team,
    this.squad,
    this.captainId,
    this.adminId,
  });

  @override
  ConsumerState createState() => _SelectSquadScreenState();
}

class _SelectSquadScreenState extends ConsumerState<SelectSquadScreen> {
  late SelectSquadViewNotifier notifier;

  @override
  void initState() {
    super.initState();
    notifier = ref.read(selectSquadStateProvider.notifier);
    runPostFrame(() => notifier.setData(
        widget.team, widget.squad ?? [], widget.captainId, widget.adminId));
  }

  @override
  Widget build(BuildContext context) {
    notifier = ref.watch(selectSquadStateProvider.notifier);
    final state = ref.watch(selectSquadStateProvider);

    return AppPage(
      title: context.l10n.select_squad_screen_title,
      actions: [
        IconButton(
            onPressed: state.isDoneBtnEnable
                ? () async {
                    var result = await SelectAdminAndCaptainDialog.show<
                        Map<String, dynamic>>(context);
                    if (result != null && context.mounted) {
                      Map<String, dynamic> updatedResult = Map.from(result);
                      updatedResult["squad"] = state.squad;
                      context.pop(updatedResult);
                    }
                  }
                : null,
            icon: Icon(
              Icons.check,
              color: state.isDoneBtnEnable
                  ? context.colorScheme.primary
                  : context.colorScheme.textDisabled,
            )),
      ],
      body: ListView(
        padding: context.mediaQueryPadding +
            const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _playingSquadList(context, notifier, state),
          _teamMemberList(context, notifier, state)
        ],
      ),
    );
  }

  Widget _playingSquadList(
    BuildContext context,
    SelectSquadViewNotifier notifier,
    SelectSquadViewState state,
  ) {
    return Wrap(
      children: [
        _sectionTitle(
          context,
          context.l10n.select_squad_playing_squad_title,
          subtitle: context.l10n.select_squad_least_require_text,
        ),
        if (state.squad.isEmpty) ...[
          _emptyList(context.l10n.select_squad_empty_squad_text)
        ] else ...[
          for (final member in state.squad) ...[
            _userProfileCell(context, notifier, member: member, isRemove: true)
          ],
        ],
      ],
    );
  }

  Widget _teamMemberList(
    BuildContext context,
    SelectSquadViewNotifier notifier,
    SelectSquadViewState state,
  ) {
    return Wrap(
      children: [
        _sectionTitle(context, context.l10n.select_squad_rest_of_team_title),
        if (state.team?.players?.isEmpty ?? true) ...[
          _emptyList(context.l10n.select_squad_empty_team_member_text)
        ] else ...[
          for (final member in getFilteredList(state)) ...[
            _userProfileCell(
              context,
              notifier,
              member: MatchPlayer(player: member),
              isRemove: false,
            )
          ],
        ],
      ],
    );
  }

  Widget _emptyList(String text) {
    return Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: AppTextStyle.subtitle1
            .copyWith(color: context.colorScheme.textSecondary),
      ),
    );
  }

  List<UserModel> getFilteredList(SelectSquadViewState state) {
    return state.team?.players
            ?.where((element) =>
                !state.squad.map((e) => e.player.id).contains(element.id))
            .toList() ??
        [];
  }

  Widget _sectionTitle(BuildContext context, String title, {String? subtitle}) {
    return Column(
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
        if (subtitle != null) ...[
          const SizedBox(
            height: 2,
          ),
          Text(
            subtitle,
            style: AppTextStyle.button
                .copyWith(color: context.colorScheme.textDisabled),
          ),
        ],
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget _userProfileCell(
    BuildContext context,
    SelectSquadViewNotifier notifier, {
    required MatchPlayer member,
    required bool isRemove,
  }) {
    return GestureDetector(
        onTap: () {
          UserDetailSheet.show(context, member.player);
        },
        child: Row(
          children: [
            ImageAvatar(
              initial: member.player.nameInitial,
              imageUrl: member.player.profile_img_url,
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
                    member.player.name ?? context.l10n.common_anonymous_title,
                    style: AppTextStyle.header4
                        .copyWith(color: context.colorScheme.textPrimary),
                  ),
                  Text(
                      member.player.player_role != null
                          ? member.player.player_role!.getString(context)
                          : context.l10n.common_not_specified_title,
                      style: AppTextStyle.subtitle2
                          .copyWith(color: context.colorScheme.textSecondary)),
                  if (member.player.phone != null) ...[
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      member.player.phone
                          .format(context, StringFormats.obscurePhoneNumber),
                      style: AppTextStyle.subtitle2
                          .copyWith(color: context.colorScheme.textSecondary),
                    ),
                  ],
                ],
              ),
            ),
            _trailingButton(
              context,
              notifier,
              member: member,
              isRemove: isRemove,
            )
          ],
        ));
  }

  Widget _trailingButton(
    BuildContext context,
    SelectSquadViewNotifier notifier, {
    required MatchPlayer member,
    required bool isRemove,
  }) {
    if (isRemove) {
      return IconButton(
          onPressed: () => notifier.removeFromSquad(member.player),
          icon: const Icon(Icons.close));
    } else {
      return OnTapScale(
        onTap: () => notifier.addToSquad(member),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
              color: context.colorScheme.containerLow,
              borderRadius: BorderRadius.circular(20)),
          child: Text(context.l10n.common_add_title.toUpperCase()),
        ),
      );
    }
  }
}
