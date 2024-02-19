import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class ImageAvatar extends StatelessWidget {
  final double size;
  final String? imageUrl;
  final String initial;
  final Color? foregroundColor;
  final Color? backgroundColor;

  const ImageAvatar({
    super.key,
    this.size = 50,
    this.imageUrl,
    required this.initial,
    this.foregroundColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor ?? context.colorScheme.containerHigh,
          border: Border.all(color: context.colorScheme.textDisabled),
          image: (imageUrl != null)
              ? DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(imageUrl!))
              : null),
      child: imageUrl == null
          ? Text(
              initial,
              style: AppTextStyle.header2.copyWith(
                color: foregroundColor ?? context.colorScheme.secondary,
              ),
            )
          : null,
    );
  }
}
