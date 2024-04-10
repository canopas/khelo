import 'package:cached_network_image/cached_network_image.dart';
import 'package:data/api/team/team_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/domain/extensions/widget_extension.dart';
import 'package:khelo/domain/formatter/date_formatter.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/matches/add_match/add_match_view_model.dart';
import 'package:khelo/ui/flow/matches/add_match/match_officials/add_match_officials_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/button/bottom_sticky_overlay.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';
import 'package:data/api/match/match_model.dart';

class AddMatchScreen extends ConsumerStatefulWidget {
  final String? matchId;

  const AddMatchScreen({super.key, this.matchId});

  @override
  ConsumerState createState() => _AddMatchScreenState();
}

class _AddMatchScreenState extends ConsumerState<AddMatchScreen> {
  late AddMatchViewNotifier notifier;

  void _observePushTossDetailScreen(
    BuildContext context,
    WidgetRef ref,
    String? matchId,
  ) {
    ref.listen(
        addMatchViewStateProvider.select((value) => value.pushTossDetailScreen),
        (previous, next) {
      if (next == true) {
        AppRoute.addTossDetail(matchId: ref.read(addMatchViewStateProvider.notifier).matchId ?? "INVALID ID")
            .pushReplacement(context);
      } else if (next == false) {
        AppRoute.scoreBoard(matchId: ref.read(addMatchViewStateProvider.notifier).matchId ?? "INVALID ID")
            .pushReplacement(context);
      }
    });
  }

  void _observePop(BuildContext context, WidgetRef ref) {
    ref.listen(addMatchViewStateProvider.select((value) => value.pop),
        (previous, next) {
      if (next != null && next) {
        context.pop();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    notifier = ref.read(addMatchViewStateProvider.notifier);
    runPostFrame(() => notifier.setData(widget.matchId));
  }

  @override
  Widget build(BuildContext context) {
    notifier = ref.watch(addMatchViewStateProvider.notifier);
    final state = ref.watch(addMatchViewStateProvider);

    _observePushTossDetailScreen(context, ref, notifier.matchId);
    _observePop(context, ref);

    return AppPage(
      title: (widget.matchId != null)
          ? context.l10n.add_match_screen_edit_match_title
          : context.l10n.add_match_screen_title,
      actions: [
        if (widget.matchId != null)
          _deleteMatchButton(context, onDelete: notifier.deleteMatch),
        _scheduleMatchButton(
          context,
          isSaveBtnEnable: state.isSaveBtnEnable,
          onSchedule: () => notifier.addMatch(),
        ),
      ],
      body: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            _body(context, notifier, state),
            _stickyButton(context, notifier, state),
          ],
        ),
      ),
    );
  }

  Widget _scheduleMatchButton(
    BuildContext context, {
    required bool isSaveBtnEnable,
    required Function() onSchedule,
  }) {
    return IconButton(
      onPressed: isSaveBtnEnable ? onSchedule : null,
      icon: Icon(
        Icons.alarm,
        color: isSaveBtnEnable
            ? context.colorScheme.primary
            : context.colorScheme.textDisabled,
      ),
    );
  }

  Widget _deleteMatchButton(
    BuildContext context, {
    required Function() onDelete,
  }) {
    return IconButton(
      onPressed: () => _showDeleteAlert(
        context,
        onDelete: onDelete,
      ),
      icon: const Icon(
        Icons.delete_outline,
      ),
    );
  }

  Widget _body(
    BuildContext context,
    AddMatchViewNotifier notifier,
    AddMatchViewState state,
  ) {
    if (state.loading) {
      return const Center(child: AppProgressIndicator());
    }
    return ListView(
      padding: context.mediaQueryPadding + BottomStickyOverlay.padding,
      children: [
        _selectTeam(context, notifier, state),
        const SizedBox(
          height: 24,
        ),
        const Divider(),
        _capsuleOptionList(context, notifier, state, false),
        const SizedBox(
          height: 24,
        ),
        _overDetail(context, notifier, state),
        const SizedBox(
          height: 24,
        ),
        _powerPlayButton(context, notifier, state),
        const SizedBox(
          height: 24,
        ),
        _inputField(
          context: context,
          controller: state.cityController,
          hintText: context.l10n.add_match_city_title,
          onChange: () => notifier.onTextChange(),
        ),
        const SizedBox(
          height: 24,
        ),
        _inputField(
          context: context,
          controller: state.groundController,
          hintText: context.l10n.add_match_ground_title,
          onChange: () => notifier.onTextChange(),
        ),
        _matchDateTime(context, notifier, state),
        _ballTypeList(context, notifier, state),
        _capsuleOptionList(context, notifier, state, true),
        _matchOfficialsList(context, notifier, state),
        const SizedBox(
          height: 24,
        ),
      ],
    );
  }

  Widget _selectTeam(
    BuildContext context,
    AddMatchViewNotifier notifier,
    AddMatchViewState state,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _selectTeamCell(context, notifier, state, TeamType.a),
          Text(
            context.l10n.add_match_versus_short_title,
            style: AppTextStyle.header1
                .copyWith(color: context.colorScheme.textPrimary),
          ),
          _selectTeamCell(context, notifier, state, TeamType.b),
        ],
      ),
    );
  }

  Widget _selectTeamCell(
    BuildContext context,
    AddMatchViewNotifier notifier,
    AddMatchViewState state,
    TeamType type,
  ) {
    final TeamModel? team = type == TeamType.a ? state.teamA : state.teamB;
    return Column(
      children: [
        OnTapScale(
          onTap: () async {
            final team = await AppRoute.searchTeam(excludedIds: [
              state.teamA?.id ?? "INVALID ID",
              state.teamB?.id ?? "INVALID ID"
            ]).push<TeamModel>(context);
            if (team != null && context.mounted) {
              notifier.onTeamSelect(team, type);
            }
          },
          child: Container(
            height: 120,
            width: 120,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: context.colorScheme.containerLowOnSurface,
                shape: BoxShape.circle,
                image: (team != null && team.profile_img_url != null)
                    ? DecorationImage(
                        image:
                            CachedNetworkImageProvider(team.profile_img_url!),
                        fit: BoxFit.cover)
                    : null,
                border: Border.all(
                    width: 2,
                    color: context.colorScheme.containerNormalOnSurface)),
            child: (team == null)
                ? Text(
                    type.getString(context),
                    style: AppTextStyle.header1
                        .copyWith(color: context.colorScheme.textDisabled),
                  )
                : (team.profile_img_url == null)
                    ? Text(
                        team.name[0].toUpperCase(),
                        style: AppTextStyle.header1.copyWith(
                            color: context.colorScheme.textDisabled,
                            fontSize: 45),
                      )
                    : null,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        if (team != null) ...[
          Text(
            team.name,
            textAlign: TextAlign.center,
            style: AppTextStyle.header4
                .copyWith(color: context.colorScheme.textSecondary),
            maxLines: 2,
          ),
          const SizedBox(
            height: 4,
          ),
          _selectSquadButton(context, notifier, state, team, type),
        ],
      ],
    );
  }

  Widget _selectSquadButton(
    BuildContext context,
    AddMatchViewNotifier notifier,
    AddMatchViewState state,
    TeamModel team,
    TeamType type,
  ) {
    return OnTapScale(
        onTap: () async {
          final squad = await AppRoute.selectSquad(
            team: team,
            squad: type == TeamType.a ? state.squadA : state.squadB,
            captainId: type == TeamType.a
                ? state.teamACaptainId
                : state.teamBCaptainId,
            adminId:
                type == TeamType.a ? state.teamAAdminId : state.teamBAdminId,
          ).push<Map<String, dynamic>>(context);
          if (squad != null && context.mounted) {
            notifier.onSquadSelect(type, squad);
          }
        },
        child: Text(
          context.l10n.add_match_select_squad_title,
          style:
              AppTextStyle.button.copyWith(color: context.colorScheme.primary),
        ));
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

  Widget _matchDateTime(
    BuildContext context,
    AddMatchViewNotifier notifier,
    AddMatchViewState state,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(context, context.l10n.add_match_match_schedule_title),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: OnTapScale(
            onTap: () => _selectDateTime(context, notifier, state),
            child: Text.rich(TextSpan(children: [
              WidgetSpan(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.calendar_today,
                      color: context.colorScheme.textPrimary),
                ),
              ),
              TextSpan(
                  text: state.matchTime
                      .format(context, DateFormatType.dateAndTime),
                  style: AppTextStyle.subtitle1.copyWith(
                      color: context.colorScheme.textSecondary, fontSize: 22)),
            ])),
          ),
        ),
      ],
    );
  }

  Widget _inputField({
    required BuildContext context,
    required TextEditingController controller,
    required String hintText,
    bool allowNumberOnly = false,
    required Function() onChange,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        controller: controller,
        onChanged: (value) => onChange(),
        inputFormatters: allowNumberOnly
            ? [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ]
            : null,
        style: AppTextStyle.subtitle1
            .copyWith(color: context.colorScheme.textPrimary, fontSize: 16),
        decoration: InputDecoration(
            hintStyle: AppTextStyle.subtitle1
                .copyWith(color: context.colorScheme.textDisabled),
            hintText: hintText,
            border: const OutlineInputBorder()),
      ),
    );
  }

  Widget _capsuleOptionList(
    BuildContext context,
    AddMatchViewNotifier notifier,
    AddMatchViewState state,
    bool isForPitchType,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
            context,
            isForPitchType
                ? context.l10n.add_match_pitch_type_title
                : context.l10n.add_match_match_type_title),
        SizedBox(
          height: 45,
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(
                    width: 16,
                  ),
                  for (final value in (isForPitchType)
                      ? PitchType.values
                      : MatchType.values) ...[
                    _capsuleCell(
                      context: context,
                      title: (isForPitchType)
                          ? (value as PitchType).getString(context)
                          : (value as MatchType).getString(context),
                      isSelected: (isForPitchType)
                          ? state.pitchType == value
                          : state.matchType == value,
                      onTap: () => (isForPitchType)
                          ? notifier.onPitchTypeSelection(value as PitchType)
                          : notifier.onMatchTypeSelection(value as MatchType),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                  ],
                ],
              )),
        ),
      ],
    );
  }

  Widget _capsuleCell({
    required BuildContext context,
    required String title,
    required bool isSelected,
    required Function() onTap,
  }) {
    return OnTapScale(
      onTap: () => onTap(),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            border: isSelected
                ? null
                : Border.all(
                    color: context.colorScheme.containerNormalOnSurface),
            color: isSelected
                ? context.colorScheme.primary
                : context.colorScheme.containerLowOnSurface,
            borderRadius: BorderRadius.circular(40)),
        child: Text(
          title,
          style: AppTextStyle.button
              .copyWith(color: context.colorScheme.textSecondary, fontSize: 20),
        ),
      ),
    );
  }

  Widget _powerPlayButton(
    BuildContext context,
    AddMatchViewNotifier notifier,
    AddMatchViewState state,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: OnTapScale(
          onTap: () async {
            final res = await AppRoute.powerPlay(
                    totalOvers: int.parse(state.totalOverController.text),
                    firstPowerPlay: state.firstPowerPlay,
                    secondPowerPlay: state.secondPowerPlay,
                    thirdPowerPlay: state.thirdPowerPlay)
                .push<List<List<int>>>(context);
            if (res != null && context.mounted) {
              notifier.onPowerPlayChange(res);
            }
          },
          enabled: state.isPowerPlayButtonEnable,
          child: Text(
            context.l10n.add_match_power_play_overs_title,
            textAlign: TextAlign.center,
            style: AppTextStyle.subtitle1.copyWith(
                color: state.isPowerPlayButtonEnable
                    ? context.colorScheme.primary
                    : context.colorScheme.textDisabled),
          )),
    );
  }

  Widget _ballTypeList(
    BuildContext context,
    AddMatchViewNotifier notifier,
    AddMatchViewState state,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(context, context.l10n.add_match_ball_type_title),
        SizedBox(
          height: 90,
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(
                    width: 16,
                  ),
                  for (final type in BallType.values) ...[
                    _ballTypeCell(
                      context: context,
                      title: type.getString(context),
                      image: _getBallTypeImage(context, type),
                      isSelected: state.ballType == type,
                      onTap: () => notifier.onBallTypeSelection(type),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                  ],
                ],
              )),
        ),
      ],
    );
  }

  Widget _ballTypeCell({
    required BuildContext context,
    required String title,
    required String image,
    required bool isSelected,
    required Function() onTap,
  }) {
    return OnTapScale(
      onTap: () => onTap(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 65,
                  width: 65,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: isSelected
                        ? null
                        : Border.all(
                            color:
                                context.colorScheme.containerNormalOnSurface),
                    shape: BoxShape.circle,
                    image: DecorationImage(image: AssetImage(image)),
                    color: isSelected
                        ? context.colorScheme.primary
                        : context.colorScheme.containerLowOnSurface,
                  ),
                ),
                isSelected
                    ? Container(
                        height: 65,
                        width: 65,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black38,
                        ),
                        child: const Icon(
                          Icons.check,
                          size: 38,
                          color: Colors.white,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyle.subtitle1
                .copyWith(color: context.colorScheme.textPrimary),
          )
        ],
      ),
    );
  }

  Widget _matchOfficialsList(
    BuildContext context,
    AddMatchViewNotifier notifier,
    AddMatchViewState state,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(context, context.l10n.add_match_match_officials_title),
        SizedBox(
          height: 120,
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(
                    width: 16,
                  ),
                  _matchOfficialsCell(
                    context: context,
                    notifier: notifier,
                    state: state,
                    title: context.l10n.add_match_officials_umpires_title,
                    image: "assets/images/ic_umpire.png",
                  ),
                  _matchOfficialsCell(
                    context: context,
                    notifier: notifier,
                    state: state,
                    title: context.l10n.add_match_officials_scorers_title,
                    image: "assets/images/ic_scorer.png",
                  ),
                  _matchOfficialsCell(
                    context: context,
                    notifier: notifier,
                    state: state,
                    title:
                        context.l10n.add_match_officials_live_streamers_title,
                    image: "assets/images/ic_streamer.png",
                  ),
                  _matchOfficialsCell(
                    context: context,
                    notifier: notifier,
                    state: state,
                    title: context.l10n.add_match_officials_others_title,
                    image: "assets/images/ic_other_official.png",
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                ],
              )),
        ),
      ],
    );
  }

  Widget _matchOfficialsCell({
    required BuildContext context,
    required AddMatchViewNotifier notifier,
    required AddMatchViewState state,
    required String title,
    required String image,
  }) {
    return OnTapScale(
      onTap: () async {
        final officials =
            await AppRoute.addMatchOfficials(officials: state.officials)
                .push<List<Officials>>(context);
        if (officials != null && context.mounted) {
          notifier.setOfficials(officials);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: 110,
              width: 110,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(
                    color: context.colorScheme.containerNormalOnSurface),
                shape: BoxShape.circle,
                color: context.colorScheme.containerLowOnSurface,
              ),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                color: context.colorScheme.textDisabled,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyle.subtitle1
                .copyWith(color: context.colorScheme.textSecondary),
          )
        ],
      ),
    );
  }

  Widget _stickyButton(
    BuildContext context,
    AddMatchViewNotifier notifier,
    AddMatchViewState state,
  ) {
    return BottomStickyOverlay(
      child: PrimaryButton(
        context.l10n.add_match_start_match_title,
        enabled: state.isStartBtnEnable,
        progress: state.isAddMatchInProgress,
        onPressed: () => notifier.addMatch(startMatch: true),
      ),
    );
  }

  Future<void> _selectDateTime(
    BuildContext context,
    AddMatchViewNotifier notifier,
    AddMatchViewState state,
  ) async {
    showDatePicker(
      context: context,
      initialDate: state.matchTime,
      firstDate: DateTime(1965),
      lastDate: DateTime(2101),
    ).then((selectedDate) {
      if (selectedDate != null) {
        showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        ).then((selectedTime) {
          if (selectedTime != null) {
            DateTime selectedDateTime = DateTime(
              selectedDate.year,
              selectedDate.month,
              selectedDate.day,
              selectedTime.hour,
              selectedTime.minute,
            );
            notifier.onDateSelect(selectedDate: selectedDateTime);
          }
        });
      }
    });
  }

  String _getBallTypeImage(BuildContext context, BallType type) {
    switch (type) {
      case BallType.leather:
        return "assets/images/ic_leather_ball.png";
      case BallType.tennis:
        return "assets/images/ic_tennis_ball.png";
      case BallType.other:
        return "assets/images/ic_other_ball.png";
    }
  }

  Widget _overDetail(
    BuildContext context,
    AddMatchViewNotifier notifier,
    AddMatchViewState state,
  ) {
    return Row(
      children: [
        Expanded(
          child: _inputField(
            context: context,
            controller: state.totalOverController,
            hintText: context.l10n.add_match_no_of_over_title,
            allowNumberOnly: true,
            onChange: () => notifier.onTextChange(),
          ),
        ),
        Expanded(
          child: _inputField(
            context: context,
            controller: state.overPerBowlerController,
            hintText: context.l10n.add_match_over_per_bowler_title,
            allowNumberOnly: true,
            onChange: () => notifier.onTextChange(),
          ),
        ),
      ],
    );
  }

  void _showDeleteAlert(
    BuildContext context, {
    required Function() onDelete,
  }) {
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: Text(context.l10n.common_delete_title),
          content: Text(context.l10n.alert_confirm_default_message(
              context.l10n.common_delete_title.toLowerCase())),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: Text(
                context.l10n.common_cancel_title,
                style: TextStyle(color: context.colorScheme.textSecondary),
              ),
            ),
            TextButton(
              onPressed: () {
                context.pop();
                onDelete();
              },
              child: Text(
                context.l10n.common_delete_title,
                style: TextStyle(color: context.colorScheme.alert),
              ),
            ),
          ],
        );
      },
    );
  }
}
