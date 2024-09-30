import 'package:data/api/tournament/tournament_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/profile_image_avatar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/gen/assets.gen.dart';
import 'package:khelo/ui/flow/tournament/add/add_tournament_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/button/bottom_sticky_overlay.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/pickers/date_and_time_picker.dart';
import 'package:style/text/app_text_field.dart';
import 'package:style/text/app_text_style.dart';
import 'package:style/widgets/adaptive_outlined_tile.dart';

import '../../../../components/action_bottom_sheet.dart';
import '../../../../components/app_page.dart';
import '../../../../components/error_snackbar.dart';
import '../../../../components/image_picker_sheet.dart';
import '../../../../domain/formatter/date_formatter.dart';

class AddTournamentScreen extends ConsumerStatefulWidget {
  const AddTournamentScreen({super.key});

  @override
  ConsumerState<AddTournamentScreen> createState() =>
      _AddTournamentScreenState();
}

class _AddTournamentScreenState extends ConsumerState<AddTournamentScreen> {
  late AddTournamentViewNotifier notifier;

  @override
  void initState() {
    super.initState();
    notifier = ref.read(addTournamentStateProvider.notifier);
  }

  void _observeActionError(BuildContext context, WidgetRef ref) {
    ref.listen(addTournamentStateProvider.select((value) => value.actionError),
        (previous, next) {
      if (next != null) {
        showErrorSnackBar(context: context, error: next);
      }
    });
  }

  void _observePop(BuildContext context, WidgetRef ref) {
    ref.listen(addTournamentStateProvider.select((value) => value.pop),
        (previous, next) {
      if (next) {
        context.pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _observeActionError(context, ref);
    _observePop(context, ref);

    final state = ref.watch(addTournamentStateProvider);

    return AppPage(
      title: context.l10n.add_tournament_screen_title,
      body: Builder(
        builder: (context) => Stack(
          children: [
            _body(context, state),
            _stickyButton(context, state),
          ],
        ),
      ),
    );
  }

  Widget _body(BuildContext context, AddTournamentState state) {
    return ListView(
      padding: context.mediaQueryPadding + const EdgeInsets.all(16),
      children: [
        _profileView(context, state),
        AppTextField(
          controller: state.nameController,
          label: context.l10n.add_tournament_name,
          onChanged: (_) => notifier.onChange(),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          borderRadius: BorderRadius.circular(12),
          borderType: AppTextFieldBorderType.outline,
          borderColor: BorderColor(
            focusColor: context.colorScheme.outline,
            unFocusColor: context.colorScheme.outline,
          ),
        ),
        const SizedBox(height: 16),
        _selectTileView(
          label: context.l10n.add_tournament_type,
          title: state.selectedType.getString(context),
          icon: Icons.keyboard_arrow_down_rounded,
          onTap: () {
            _selectTypeSheet(
              context,
              selectedType: state.selectedType,
              onSelected: (type) => notifier.onSelectType(type),
            );
          },
        ),
        const SizedBox(height: 16),
        _dateScheduleView(context, state),
      ],
    );
  }

  Widget _stickyButton(
    BuildContext context,
    AddTournamentState state,
  ) {
    return BottomStickyOverlay(
      child: PrimaryButton(
        context.l10n.common_create,
        progress: state.loading,
        enabled: state.enableButton,
        onPressed: () => notifier.addTournament(),
      ),
    );
  }

  Widget _profileView(BuildContext context, AddTournamentState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: ProfileImageAvatar(
        size: 120,
        isLoading: state.imageUploading && state.filePath == null,
        shape: BoxShape.rectangle,
        filePath: state.filePath,
        imageUrl: state.imageUrl,
        placeHolderImage: Assets.images.icTournaments,
        placeHolderColor: context.colorScheme.textPrimary,
        color: context.colorScheme.containerHigh,
        borderRadius: BorderRadius.circular(16),
        onEditButtonTap: () async {
          final imagePath = await ImagePickerSheet.show<String>(context, true);
          if (imagePath != null) {
            notifier.onImageChange(imagePath);
          }
        },
      ),
    );
  }

  Widget _selectTileView({
    String? label,
    IconData? icon,
    required String title,
    required Function() onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label,
            style: AppTextStyle.body2.copyWith(
              color: context.colorScheme.textDisabled,
            ),
          ),
          const SizedBox(height: 12),
        ],
        OnTapScale(
          onTap: onTap,
          child: Material(
            type: MaterialType.transparency,
            child: ListTile(
              dense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: context.colorScheme.outline),
                borderRadius: BorderRadius.circular(12),
              ),
              title: Text(
                title,
                style: AppTextStyle.body2.copyWith(
                  color: context.colorScheme.textPrimary,
                ),
              ),
              trailing: Icon(
                icon,
                color: context.colorScheme.textDisabled,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _dateScheduleView(
    BuildContext context,
    AddTournamentState state,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: AdaptiveOutlinedTile(
                  title: state.startDate.format(context, DateFormatType.date),
                  headerText: context.l10n.add_tournament_start_date,
                  placeholder: context.l10n.add_tournament_start_date,
                  onTap: () {
                    selectDate(
                      context,
                      initialDate: state.startDate,
                      onDateSelected: (date) => notifier.onStartDate(date),
                    );
                  }),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: AdaptiveOutlinedTile(
                  title: state.endDate.format(context, DateFormatType.date),
                  headerText: context.l10n.add_tournament_end_date,
                  placeholder: context.l10n.add_tournament_end_date,
                  onTap: () {
                    selectDate(
                      context,
                      initialDate: state.endDate,
                      onDateSelected: (date) => notifier.onEndDate(date),
                    );
                  }),
            ),
          ],
        ),
      ],
    );
  }

  void _selectTypeSheet(
    BuildContext context, {
    required TournamentType selectedType,
    required Function(TournamentType) onSelected,
  }) {
    showActionBottomSheet(
      context: context,
      heightFactor: 0.8,
      items: TournamentType.values
          .map(
            (type) => BottomSheetAction(
              title: type.getString(context),
              subTitle: type.getDescriptionString(context),
              enabled: selectedType != type,
              child: (selectedType == type)
                  ? SvgPicture.asset(
                      Assets.images.icCheck,
                      colorFilter: ColorFilter.mode(
                        context.colorScheme.primary,
                        BlendMode.srcATop,
                      ),
                    )
                  : null,
              onTap: () {
                context.pop();
                onSelected.call(type);
              },
            ),
          )
          .toList(),
    );
  }
}
