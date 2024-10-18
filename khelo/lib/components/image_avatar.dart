import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class ImageAvatar extends StatelessWidget {
  final double size;
  final String? imageUrl;
  final String initial;
  final Border? border;
  final Color? foregroundColor;
  final Color? backgroundColor;

  const ImageAvatar({
    super.key,
    this.size = 50,
    this.imageUrl,
    this.border,
    required this.initial,
    this.foregroundColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return MediaQuery.withNoTextScaling(
      child: Container(
        height: size,
        width: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: border,
          color: backgroundColor ?? context.colorScheme.containerHigh,
        ),
        child: imageUrl == null
            ? _initialView(context)
            : CachedNetworkImage(
                imageUrl: imageUrl!,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => _initialView(context),
                placeholder: (context, url) => _initialView(context),
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _initialView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          initial,
          textAlign: TextAlign.center,
          style: AppTextStyle.subtitle1.copyWith(
              color: foregroundColor ?? context.colorScheme.textPrimary,
              fontSize: size / 2.15),
        ),
      ),
    );
  }
}
