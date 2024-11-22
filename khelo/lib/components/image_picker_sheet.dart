import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

import '../gen/assets.gen.dart';

class ImagePickerSheet extends ConsumerWidget {
  static Future<T?> show<T>(
    BuildContext context, {
    required bool allowCrop,
    bool cropOriginal = false,
  }) {
    HapticFeedback.mediumImpact();
    return showModalBottomSheet(
      context: context,
      backgroundColor: context.colorScheme.surface,
      showDragHandle: true,
      builder: (context) {
        return ImagePickerSheet(
            allowCrop: allowCrop,
            cropOriginal: cropOriginal,
            onPop: (String? imagePath) {
              context.pop(imagePath);
            });
      },
    );
  }

  final bool allowCrop;
  final bool cropOriginal;
  final void Function(String? imagePath) onPop;

  ImagePickerSheet({
    super.key,
    required this.allowCrop,
    required this.onPop,
    this.cropOriginal = false,
  });

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: context.mediaQueryPadding +
          const EdgeInsets.only(left: 16, right: 16, bottom: 34),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            context.l10n.image_picker_choose_option_title,
            style: AppTextStyle.header3
                .copyWith(color: context.colorScheme.textPrimary),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _sheetOptionCell(
                context,
                image: Assets.images.icCamera,
                option: context.l10n.image_picker_camera_option_text,
                onTap: () async {
                  final image = await _picker.pickImage(
                    source: ImageSource.camera,
                    requestFullMetadata: false,
                  );
                  if (allowCrop) {
                    if (context.mounted && image != null) {
                      final croppedFile = await _openCropImage(context, image);
                      onPop(croppedFile?.path);
                    }
                  } else {
                    if (image != null) {
                      onPop(image.path);
                    }
                  }
                },
              ),
              _sheetOptionCell(
                context,
                image: Assets.images.icGallery,
                option: context.l10n.image_picker_gallery_option_text,
                onTap: () async {
                  final image = await _picker.pickImage(
                    source: ImageSource.gallery,
                    requestFullMetadata: false,
                  );
                  if (allowCrop) {
                    if (context.mounted && image != null) {
                      final croppedFile = await _openCropImage(context, image);
                      onPop(croppedFile?.path);
                    }
                  } else {
                    if (image != null) {
                      onPop(image.path);
                    }
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _sheetOptionCell(
    BuildContext context, {
    required String image,
    required String option,
    required VoidCallback onTap,
  }) {
    return OnTapScale(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: context.colorScheme.containerLow,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: context.colorScheme.containerHigh,
              child: SvgPicture.asset(
                image,
                fit: BoxFit.contain,
                colorFilter: ColorFilter.mode(
                    context.colorScheme.textPrimary, BlendMode.srcATop),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              option,
              style: AppTextStyle.subtitle1
                  .copyWith(color: context.colorScheme.textPrimary),
            )
          ],
        ),
      ),
    );
  }

  Future<CroppedFile?> _openCropImage(BuildContext context, XFile image) async {
    final croppedImage = await ImageCropper().cropImage(
      sourcePath: image.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: context.l10n.image_picker_crop_image_title,
          toolbarColor: context.colorScheme.primary,
          toolbarWidgetColor: context.colorScheme.onPrimary,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
          aspectRatioPresets: [
            cropOriginal
                ? CropAspectRatioPreset.original
                : CropAspectRatioPreset.square
          ],
        ),
        IOSUiSettings(
          title: context.l10n.image_picker_crop_image_title,
          aspectRatioPresets: [
            cropOriginal
                ? CropAspectRatioPreset.original
                : CropAspectRatioPreset.square
          ],
        ),
        WebUiSettings(context: context),
      ],
    );

    return croppedImage;
  }
}
