import 'package:data/api/match/match_model.dart';
import 'package:data/api/team/team_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/action_bottom_sheet.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/error_screen.dart';
import 'package:khelo/components/error_snackbar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/domain/extensions/widget_extension.dart';
import 'package:khelo/domain/formatter/date_formatter.dart';
import 'package:khelo/gen/assets.gen.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/matches/add_match/add_match_view_model.dart';
import 'package:khelo/ui/flow/matches/add_match/components/ball_selection_view.dart';
import 'package:khelo/ui/flow/matches/add_match/components/match_official_selection_view.dart';
import 'package:khelo/ui/flow/matches/add_match/components/over_detail_view.dart';
import 'package:khelo/ui/flow/matches/add_match/components/pitch_selection_view.dart';
import 'package:khelo/ui/flow/matches/add_match/components/section_title.dart';
import 'package:khelo/ui/flow/matches/add_match/components/team_selection_view.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/button/action_button.dart';
import 'package:style/button/bottom_sticky_overlay.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/pickers/date_and_time_picker.dart';
import 'package:style/text/app_text_field.dart';
import 'package:style/text/app_text_style.dart';
import 'package:style/widgets/adaptive_outlined_tile.dart';

import '../../../../components/confirmation_dialog.dart';

class AddMatchScreen extends ConsumerStatefulWidget {
  final String? matchId;
  final TeamModel? defaultTeam;
  final TeamModel? defaultOpponent;
  final String? tournamentId;
  final MatchGroup? group;
  final int? groupNumber;

  const AddMatchScreen({
    super.key,
    this.matchId,
    this.defaultTeam,
    this.defaultOpponent,
    this.groupNumber,
    this.group,
    this.tournamentId,
  });

  @override
  ConsumerState createState() => _AddMatchScreenState();
}

class _AddMatchScreenState extends ConsumerState<AddMatchScreen> {
  late AddMatchViewNotifier notifier;

  @override
  void initState() {
    super.initState();
    notifier = ref.read(addMatchViewStateProvider.notifier);
    runPostFrame(() => notifier.setData(
        widget.matchId,
        widget.defaultTeam,
        widget.defaultOpponent,
        widget.tournamentId,
        widget.group,
        widget.groupNumber));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addMatchViewStateProvider);

    _observeActionError(context, ref);
    _observePushTossDetailScreen(context, ref, notifier.matchId);
    _observeMatch(context, ref);

    return AppPage(
      title: (widget.matchId != null)
          ? context.l10n.add_match_screen_edit_match_title
          : context.l10n.add_match_screen_title,
      actions: [
        _scheduleMatchButton(
          context,
          saveBtnError: state.saveBtnError,
          onSchedule: () => notifier.addMatch(),
        ),
        if (widget.matchId != null)
          _deleteMatchButton(context, onDelete: notifier.deleteMatch),
      ],
      body: Builder(builder: (context) {
        return Stack(
          children: [
            _body(context, notifier, state),
            _stickyButton(context, notifier, state),
          ],
        );
      }),
    );
  }

  Widget _scheduleMatchButton(
    BuildContext context, {
    AddMatchErrorType? saveBtnError,
    required VoidCallback onSchedule,
  }) {
    return actionButton(
      context,
      onPressed: () => saveBtnError == null
          ? onSchedule()
          : showErrorSnackBar(
              context: context,
              error: saveBtnError.getString(context),
            ),
      icon: SvgPicture.asset(
        Assets.images.icSave,
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(
            saveBtnError == null
                ? context.colorScheme.textPrimary
                : context.colorScheme.textDisabled,
            BlendMode.srcIn),
      ),
    );
  }

  Widget _deleteMatchButton(
    BuildContext context, {
    required VoidCallback onDelete,
  }) {
    return actionButton(context,
        onPressed: () => showConfirmationDialog(
              context,
              title: context.l10n.common_delete_title,
              message: context.l10n.alert_confirm_default_message(
                  context.l10n.common_delete_title.toLowerCase()),
              confirmBtnText: context.l10n.common_delete_title,
              onConfirm: onDelete,
            ),
        icon: SvgPicture.asset(
          Assets.images.icBin,
          height: 24,
          width: 24,
          fit: BoxFit.contain,
          colorFilter:
              ColorFilter.mode(context.colorScheme.alert, BlendMode.srcATop),
        ));
  }

  Widget _body(
    BuildContext context,
    AddMatchViewNotifier notifier,
    AddMatchViewState state,
  ) {
    if (state.loading) {
      return const Center(child: AppProgressIndicator());
    }
    if (state.error != null) {
      return ErrorScreen(
        error: state.error,
        onRetryTap: notifier.getMatchById,
      );
    }

    return ListView(
      padding: context.mediaQueryPadding +
          BottomStickyOverlay.padding +
          const EdgeInsets.symmetric(vertical: 24),
      children: [
        TeamSelectionView(notifier: notifier, state: state),
        const SizedBox(height: 24),
        SectionTitle(
            title: context.l10n.add_match_match_type_title,
            trailing: _matchTypeButton(
              context,
              state,
              notifier.onMatchTypeSelection,
            )),
        OverDetailView(notifier: notifier, state: state),
        const SizedBox(height: 16),
        _inputField(
          context: context,
          controller: state.groundController,
          hintText: context.l10n.add_match_ground_title,
          onChange: notifier.onTextChange,
        ),
        const SizedBox(height: 16),
        _inputField(
          context: context,
          controller: state.cityController,
          hintText: context.l10n.common_city_title,
          onChange: notifier.onTextChange,
        ),
        _matchScheduleView(context, notifier, state),
        BallSelectionView(notifier: notifier, state: state),
        PitchSelectionView(notifier: notifier, state: state),
        MatchOfficialSelectionView(notifier: notifier, state: state),
      ],
    );
  }

  Widget? showCheckMark(
    BuildContext context, {
    required bool showCheck,
  }) {
    return showCheck
        ? SvgPicture.asset(
            Assets.images.icCheck,
            height: 24,
            width: 24,
            colorFilter: ColorFilter.mode(
              context.colorScheme.primary,
              BlendMode.srcATop,
            ),
          )
        : null;
  }

  Widget _matchTypeButton(BuildContext context, AddMatchViewState state,
      Function(MatchType) onTap) {
    return OnTapScale(
      onTap: () {
        showActionBottomSheet(
            context: context,
            items: MatchType.values
                .map((type) => BottomSheetAction(
                      title: type.getString(context),
                      enabled: state.matchType != type,
                      child: showCheckMark(
                        context,
                        showCheck: state.matchType == type,
                      ),
                      onTap: () {
                        context.pop();
                        onTap(type);
                      },
                    ))
                .toList());
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: context.colorScheme.primary,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(children: [
          Text(state.matchType.getString(context),
              style: AppTextStyle.body2
                  .copyWith(color: context.colorScheme.onPrimary)),
          const SizedBox(width: 8),
          SvgPicture.asset(
            Assets.images.icArrowDown,
            height: 18,
            width: 18,
            colorFilter: ColorFilter.mode(
                context.colorScheme.onPrimary, BlendMode.srcATop),
          )
        ]),
      ),
    );
  }

  Widget _inputField({
    required BuildContext context,
    required TextEditingController controller,
    required String hintText,
    bool allowNumberOnly = false,
    required VoidCallback onChange,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: AppTextField(
        controller: controller,
        borderRadius: BorderRadius.circular(12),
        borderType: AppTextFieldBorderType.outline,
        hintText: hintText,
        hintStyle: AppTextStyle.subtitle3
            .copyWith(color: context.colorScheme.textDisabled),
        style: AppTextStyle.subtitle3
            .copyWith(color: context.colorScheme.textPrimary),
        borderColor: BorderColor(
          focusColor: context.colorScheme.outline,
          unFocusColor: context.colorScheme.outline,
        ),
        keyboardType: allowNumberOnly ? TextInputType.number : null,
        inputFormatters: allowNumberOnly
            ? [
                FilteringTextInputFormatter.digitsOnly,
              ]
            : null,
        onChanged: (value) => onChange(),
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
        progress: state.isAddMatchInProgress,
        onPressed: () => state.startBtnError != null
            ? showErrorSnackBar(
                context: context,
                error: state.startBtnError!.getString(context))
            : notifier.addMatch(startMatch: true),
      ),
    );
  }

  Widget _matchScheduleView(
    BuildContext context,
    AddMatchViewNotifier notifier,
    AddMatchViewState state,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: context.l10n.add_match_match_schedule_title),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Expanded(
                child: AdaptiveOutlinedTile(
                    title: state.matchTime.format(context, DateFormatType.date),
                    headerImage: Assets.images.icCalendar,
                    headerText: context.l10n.add_match_date_title,
                    placeholder: context.l10n.add_match_date_title,
                    onTap: () {
                      selectDate(
                        context,
                        initialDate: state.matchTime,
                        onDateSelected: (selectedDate) =>
                            notifier.onDateSelect(selectedDate: selectedDate),
                      );
                    }),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AdaptiveOutlinedTile(
                    title: state.matchTime.format(context, DateFormatType.time),
                    headerImage: Assets.images.icTime,
                    headerText: context.l10n.add_match_time_title,
                    placeholder: context.l10n.add_match_time_title,
                    onTap: () {
                      selectTime(
                        context,
                        initialTime: state.matchTime,
                        onTimeSelected: (selectedTime) =>
                            notifier.onDateSelect(selectedDate: selectedTime),
                      );
                    }),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _observeActionError(BuildContext context, WidgetRef ref) {
    ref.listen(addMatchViewStateProvider.select((value) => value.actionError),
        (previous, next) {
      if (next != null) {
        showErrorSnackBar(context: context, error: next);
      }
    });
  }

  void _observePushTossDetailScreen(
    BuildContext context,
    WidgetRef ref,
    String? matchId,
  ) {
    ref.listen(
        addMatchViewStateProvider.select((value) => value.pushTossDetailScreen),
        (previous, next) {
      if (next == true) {
        AppRoute.addTossDetail(
                matchId: ref.read(addMatchViewStateProvider.notifier).matchId ??
                    "INVALID ID")
            .pushReplacement(context);
      } else if (next == false) {
        AppRoute.scoreBoard(
                matchId: ref.read(addMatchViewStateProvider.notifier).matchId ??
                    "INVALID ID")
            .pushReplacement(context);
      }
    });
  }

  void _observeMatch(BuildContext context, WidgetRef ref) {
    ref.listen(addMatchViewStateProvider.select((value) => value.match),
        (previous, next) {
      if (next != null) {
        context.pop(next);
      }
    });
  }
}
