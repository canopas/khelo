import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khelo/gen/assets.gen.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';

class ProfileImageAvatar extends StatelessWidget {
  final double size;
  final String? imageUrl;
  final String? filePath;
  final String? placeHolderImage;
  final bool isLoading;
  final Alignment alignment;
  final VoidCallback onEditButtonTap;

  const ProfileImageAvatar({
    super.key,
    required this.size,
    this.imageUrl,
    this.filePath,
    this.placeHolderImage,
    required this.isLoading,
    required this.onEditButtonTap,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: SizedBox(
        height: size,
        width: size,
        child: Stack(
          children: [
            _roundedImageView(context),
            _editImageButton(context, onTap: onEditButtonTap)
          ],
        ),
      ),
    );
  }

  Widget _roundedImageView(BuildContext context) {
    return Container(
      height: size,
      width: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.colorScheme.primary,
          image: (filePath != null)
              ? DecorationImage(
                  image: FileImage(File(filePath!)),
                  fit: BoxFit.cover,
                )
              : null),
      child: (filePath != null)
          ? null
          : (imageUrl != null && !isLoading)
              ? CachedNetworkImage(
                  imageUrl: imageUrl!,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) =>
                      _placeHolderIcon(context),
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              : _imagePlaceHolder(context),
    );
  }

  Widget? _imagePlaceHolder(BuildContext context) {
    return imageUrl == null && !isLoading
        ? _placeHolderIcon(context)
        : isLoading
            ? AppProgressIndicator(color: context.colorScheme.surface)
            : null;
  }

  Widget _placeHolderIcon(BuildContext context) {
    return SvgPicture.asset(
      placeHolderImage ?? Assets.images.icProfileThin,
      height: size / 3,
      width: size / 3,
      colorFilter: ColorFilter.mode(
        context.colorScheme.textInversePrimary,
        BlendMode.srcATop,
      ),
    );
  }

  Widget _editImageButton(
    BuildContext context, {
    required VoidCallback onTap,
  }) {
    return Align(
      alignment: Alignment.bottomRight,
      child: OnTapScale(
        onTap: onTap,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  border: Border.all(color: context.colorScheme.textPrimary),
                  shape: BoxShape.circle),
            ),
            SvgPicture.asset(
              Assets.images.icEdit,
              height: 18,
              width: 18,
              colorFilter: ColorFilter.mode(
                context.colorScheme.textPrimary,
                BlendMode.srcATop,
              ),
            )
          ],
        ),
      ),
    );
  }
}
