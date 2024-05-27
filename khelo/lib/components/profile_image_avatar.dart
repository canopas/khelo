import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khelo/gen/assets.gen.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';

class ProfileImageAvatar extends StatelessWidget {
  final double size;
  final String? imageUrl;
  final String placeHolderImage;
  final bool isLoading;
  final Function() onEditButtonTap;

  const ProfileImageAvatar({
    super.key,
    required this.size,
    this.imageUrl,
    required this.placeHolderImage,
    required this.isLoading,
    required this.onEditButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
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
          image: imageUrl != null && !isLoading
              ? DecorationImage(
                  image: CachedNetworkImageProvider(imageUrl!),
                  fit: BoxFit.cover)
              : null,
          color: context.colorScheme.primary),
      child: _imagePlaceHolder(context),
    );
  }

  Widget? _imagePlaceHolder(BuildContext context) {
    return imageUrl == null && !isLoading
        ? SvgPicture.asset(
            Assets.images.icProfileThin,
            height: size / 2,
            width: size / 2,
            colorFilter: ColorFilter.mode(
              context.colorScheme.textInversePrimary,
              BlendMode.srcATop,
            ),
          )
        : isLoading
            ? AppProgressIndicator(color: context.colorScheme.surface)
            : null;
  }

  Widget _editImageButton(
    BuildContext context, {
    required Function() onTap,
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