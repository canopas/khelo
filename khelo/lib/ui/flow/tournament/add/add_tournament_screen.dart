import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:style/indicator/progress_indicator.dart';
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

  void _observeDateError(BuildContext context, WidgetRef ref) {
    ref.listen(
        addTournamentStateProvider.select((value) => value.showDateError),
        (previous, next) {
      showErrorSnackBar(
          context: context, error: context.l10n.add_tournament_date_error);
    });
  }

  @override
  Widget build(BuildContext context) {
    _observeActionError(context, ref);
    _observeDateError(context, ref);
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
      padding: context.mediaQueryPadding + BottomStickyOverlay.padding,
      children: [
        _bannerView(context, state),
        Padding(
          padding: const EdgeInsets.all(16).copyWith(top: 16),
          child: Column(
            children: [
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
              AdaptiveOutlinedTile(
                placeholder: context.l10n.add_tournament_type_placeholder,
                headerText: context.l10n.add_tournament_type,
                title: state.selectedType.getString(context),
                showTrailingIcon: true,
                onTap: () {
                  _selectTypeSheet(
                    context,
                    selectedType: state.selectedType,
                    onSelected: (type) => notifier.onSelectType(type),
                  );
                },
              ),
              const SizedBox(height: 16),
              _dateScheduleView(context, state)
            ],
          ),
        ),
      ],
    );
  }

  Widget _bannerView(BuildContext context, AddTournamentState state) {
    final bool hasBannerImage =
        state.bannerPath != null || state.bannerImgUrl != null;

    return Stack(
      children: [
        Container(
          height: 204,
          width: context.mediaQuerySize.width,
          margin: EdgeInsets.only(bottom: 45),
          decoration: BoxDecoration(
            color: context.colorScheme.containerLow,
            image: state.bannerPath != null
                ? DecorationImage(
                    image: FileImage(File(state.bannerPath!)),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (state.imageUploading) Center(child: AppProgressIndicator()),
              if (!state.imageUploading)
                hasBannerImage
                    ? _buildCachedNetworkOrFileImage(context, state)
                    : _bannerPlaceholder(context,
                        onTap: () => _pickImage(isBanner: true)),
              if (hasBannerImage && !state.imageUploading)
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: _editBannerButton(context),
                ),
            ],
          ),
        ),
        _profileView(context, state),
      ],
    );
  }

  Widget _buildCachedNetworkOrFileImage(
      BuildContext context, AddTournamentState state) {
    if (state.bannerPath != null) {
      return Image.file(
        File(state.bannerPath!),
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    } else if (state.bannerImgUrl != null) {
      return CachedNetworkImage(
        imageUrl: state.bannerImgUrl!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }
    return SizedBox.shrink(); // Fallback if neither image is available
  }

  Widget _editBannerButton(BuildContext context) {
    return TextButton.icon(
      onPressed: () => _pickImage(isBanner: true),
      icon: SvgPicture.asset(
        Assets.images.icCamera,
        colorFilter: ColorFilter.mode(
          context.colorScheme.surface,
          BlendMode.srcATop,
        ),
      ),
      label: Text(
        context.l10n.add_tournament_edit_banner,
        style:
            AppTextStyle.caption.copyWith(color: context.colorScheme.surface),
      ),
      style: TextButton.styleFrom(
        backgroundColor: context.colorScheme.textDisabled,
      ),
    );
  }

  void _pickImage({bool isBanner = false}) async {
    final imagePath = await ImagePickerSheet.show<String>(context, true);
    if (imagePath != null) {
      notifier.onImageChange(imagePath: imagePath, isBanner: isBanner);
    }
  }

  Widget _bannerPlaceholder(
    BuildContext context, {
    required Function() onTap,
  }) {
    return OnTapScale(
      onTap: onTap,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SvgPicture.asset(
          Assets.images.icCamera,
          colorFilter: ColorFilter.mode(
            context.colorScheme.textDisabled,
            BlendMode.srcATop,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          context.l10n.add_tournament_add_banner_placeholder,
          style: AppTextStyle.caption.copyWith(
            color: context.colorScheme.textDisabled,
          ),
        ),
      ]),
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
        onPressed: notifier.addTournament,
      ),
    );
  }

  Widget _profileView(BuildContext context, AddTournamentState state) {
    return Positioned(
      left: 16,
      bottom: 0,
      child: ProfileImageAvatar(
        size: 90,
        isLoading: state.imageUploading && state.profilePath == null,
        filePath: state.profilePath,
        imageUrl: state.profileImgUrl,
        placeHolderImage: Assets.images.icTournaments,
        alignment: Alignment.centerLeft,
        onEditButtonTap: _pickImage,
      ),
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
                      onDateSelected: notifier.onStartDate,
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
                      onDateSelected: notifier.onEndDate,
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