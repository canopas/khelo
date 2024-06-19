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
import 'package:style/text/app_text_field.dart';
import 'package:style/text/app_text_style.dart';
import 'package:data/api/match/match_model.dart';
import 'package:style/theme/colors.dart';
import 'package:style/widgets/adaptive_outlined_tile.dart';

class AddMatchScreen extends ConsumerStatefulWidget {
  final String? matchId;

  const AddMatchScreen({super.key, this.matchId});

  @override
  ConsumerState createState() => _AddMatchScreenState();
}

class _AddMatchScreenState extends ConsumerState<AddMatchScreen> {
  late AddMatchViewNotifier notifier;

  @override
  void initState() {
    super.initState();
    notifier = ref.read(addMatchViewStateProvider.notifier);
    runPostFrame(() => notifier.setData(widget.matchId));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addMatchViewStateProvider);

    _observeActionError(context, ref);
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
          saveBtnError: state.saveBtnError,
          onSchedule: () => notifier.addMatch(),
        ),
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
    required Function() onSchedule,
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
                ? context.colorScheme.primary
                : context.colorScheme.textDisabled,
            BlendMode.srcIn),
      ),
    );
  }

  Widget _deleteMatchButton(
    BuildContext context, {
    required Function() onDelete,
  }) {
    return actionButton(context,
        onPressed: () => _showDeleteAlert(
              context,
              onDelete: onDelete,
            ),
        icon: SvgPicture.asset(
          Assets.images.icBin,
          height: 24,
          width: 24,
          fit: BoxFit.contain,
          colorFilter:
              ColorFilter.mode(context.colorScheme.primary, BlendMode.srcATop),
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
          onChange: () => notifier.onTextChange(),
        ),
        const SizedBox(height: 16),
        _inputField(
          context: context,
          controller: state.cityController,
          hintText: context.l10n.common_city_title,
          onChange: () => notifier.onTextChange(),
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
    required Function() onChange,
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
        inputFormatters: allowNumberOnly
            ? [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
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
                      _selectDate(context, notifier, state);
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
                      _selectTime(context, notifier, state);
                    }),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(
    BuildContext context,
    AddMatchViewNotifier notifier,
    AddMatchViewState state,
  ) async {
    showDatePicker(
      context: context,
      initialDate: state.matchTime,
      firstDate: DateTime(1965),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: context.brightness == Brightness.dark
              ? materialThemeDataDark
              : materialThemeDataLight,
          child: child!,
        );
      },
    ).then((selectedDate) {
      if (selectedDate != null) {
        DateTime selectedDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          state.matchTime.hour,
          state.matchTime.minute,
        );
        notifier.onDateSelect(selectedDate: selectedDateTime);
      }
    });
  }

  Future<void> _selectTime(
    BuildContext context,
    AddMatchViewNotifier notifier,
    AddMatchViewState state,
  ) async {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: state.matchTime.hour,
        minute: state.matchTime.minute,
      ),
      builder: (context, child) {
        return Theme(
          data: context.brightness == Brightness.dark
              ? materialThemeDataDark
              : materialThemeDataLight,
          child: child!,
        );
      },
    ).then((selectedTime) {
      if (selectedTime != null) {
        DateTime selectedDateTime = DateTime(
          state.matchTime.year,
          state.matchTime.month,
          state.matchTime.day,
          selectedTime.hour,
          selectedTime.minute,
        );
        notifier.onDateSelect(selectedDate: selectedDateTime);
      }
    });
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

  void _observePop(BuildContext context, WidgetRef ref) {
    ref.listen(addMatchViewStateProvider.select((value) => value.pop),
        (previous, next) {
      if (next != null && next) {
        context.pop();
      }
    });
  }
}
