import 'package:data/api/match/match_model.dart';
import 'package:data/api/user/user_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/error_screen.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/ui/flow/matches/match_detail/match_detail_tab_view_model.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';

class MatchDetailSquadView extends ConsumerWidget {
  const MatchDetailSquadView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(matchDetailTabStateProvider);
    return _body(context, state);
  }

  _body(BuildContext context, MatchDetailTabState state){
    if (state.loading) {
      return const Center(child: AppProgressIndicator());
    }

    if (state.error != null) {
      return ErrorScreen(
        error: state.error,
        onRetryTap: () {
          // do something
        },
      );
    }

    return ListView(
        padding: context.mediaQueryPadding,
        children: _buildTeamList(context, state));
  }

  List<Widget> _buildTeamList(BuildContext context, MatchDetailTabState state) {
    List<Widget> children = [];
    if (state.match == null) {
      return children;
    }
    for (final team in state.match!.teams) {
      children.add(_sectionTitleView(context, team.team.name));
      children.add(const SizedBox(height: 8));
      children.addAll(_buildSquadList(
        context,
        team.squad,
        captainId: team.captain_id ?? "",
      ));
      children.addAll(_buildBenchList(context, team));
      children.add(const SizedBox(height: 16));
    }
    return children;
  }

  List<Widget> _buildSquadList(
    BuildContext context,
    List<MatchPlayer> squad, {
    required String captainId,
  }) {
    List<Widget> children = [];

    for (final player in squad) {
      children.add(const SizedBox(height: 8));

      children.add(_squadCellView(
        context,
        player.player,
        isCaptain: player.player.id == captainId,
      ));
    }
    return children;
  }

  List<Widget> _buildBenchList(BuildContext context, MatchTeamModel team) {
    List<Widget> children = [];
    final squadPlayerIds = team.squad.map((e) => e.player.id).toSet();
    final players = team.team.players
        ?.where((element) => !squadPlayerIds.contains(element.id))
        .toList();
    if (players == null || players.isEmpty) {
      return children;
    }
    children.add(_sectionTitleView(
      context,
      context.l10n.match_squad_bench_text,
      isSemiTitle: false,
    ));
    for (final player in players) {
      children.add(_squadCellView(
        context,
        player,
        isCaptain: false,
      ));
    }
    return children;
  }

  Widget _sectionTitleView(
    BuildContext context,
    String title, {
    bool isSemiTitle = true,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: isSemiTitle
          ? context.colorScheme.containerNormalOnSurface
          : Colors.transparent,
      child: Text(
        title,
        style: isSemiTitle
            ? AppTextStyle.subtitle1
                .copyWith(color: context.colorScheme.textPrimary)
            : AppTextStyle.header3
                .copyWith(color: context.colorScheme.textPrimary),
      ),
    );
  }

  Widget _squadCellView(
    BuildContext context,
    UserModel player, {
    bool isCaptain = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          ImageAvatar(
            initial: player.nameInitial,
            imageUrl: player.profile_img_url,
            size: 50,
          ),
          const SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${player.name}${isCaptain ? context.l10n.match_info_captain_short_title : ""}",
                style: AppTextStyle.header4
                    .copyWith(color: context.colorScheme.textPrimary),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                player.player_role?.getString(context) ?? "",
                style: AppTextStyle.subtitle1
                    .copyWith(color: context.colorScheme.textPrimary),
              )
            ],
          )
        ],
      ),
    );
  }
}
