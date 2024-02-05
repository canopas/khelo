import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class ImagePickerSheet extends ConsumerWidget {
  static Future<T?> show<T>(BuildContext context, bool allowCrop) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: context.colorScheme.containerLowOnSurface,
      showDragHandle: true,
      builder: (context) {
        return ImagePickerSheet(
            allowCrop: allowCrop,
            onPop: (String? imagePath) {
              context.pop(imagePath);
            });
      },
    );
  }

  final bool allowCrop;
  final void Function(String? imagePath) onPop;

  ImagePickerSheet({super.key, required this.allowCrop, required this.onPop});

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: context.mediaQueryPadding +
          const EdgeInsets.only(left: 16, right: 16, bottom: 24),
      child: Wrap(
        children: [
          Text(
            context.l10n.image_picker_choose_option_title,
            style: AppTextStyle.header2
                .copyWith(color: context.colorScheme.textSecondary),
          ),
          const SizedBox(
            height: 34,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //<a href="https://lovepik.com/images/png-light-line.html">Light Line Png vectors by Lovepik.com</a> GRAPHIC IMAGE LINK : camera
              _sheetOptionCell(
                context,
                "assets/images/ic_camera.png",
                () async {
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
                "assets/images/ic_gallery.png",
                () async {
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
      BuildContext context, String imagePath, VoidCallback onTap) {
    return OnTapScale(
      onTap: () => onTap(),
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(imagePath)),
            shape: BoxShape.circle,
            border: Border.all(color: context.colorScheme.containerHigh),
            color: context.colorScheme.containerLow),
      ),
    );
  }

  Future<CroppedFile?> _openCropImage(BuildContext context, XFile image) async {
    final croppedImage = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [CropAspectRatioPreset.square],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: context.l10n.image_picker_crop_image_title,
          toolbarColor: context.colorScheme.primary,
          toolbarWidgetColor: context.colorScheme.onPrimary,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: context.l10n.image_picker_crop_image_title,
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );

    return croppedImage;
  }
}
