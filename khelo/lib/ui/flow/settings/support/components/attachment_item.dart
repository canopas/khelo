import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khelo/domain/extensions/string_extensions.dart';
import 'package:style/button/action_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';

class AttachmentsTypeView extends StatelessWidget {
  final double height;
  final double width;
  final String path;
  final double borderRadius;
  final bool isNetwork;

  const AttachmentsTypeView({
    super.key,
    required this.path,
    this.height = 50,
    this.width = 50,
    this.borderRadius = 12,
    this.isNetwork = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: context.colorScheme.containerNormal,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: _getFileView(
        iconColor: context.colorScheme.textDisabled,
        path: path,
      ),
    );
  }

  Widget _getFileView({
    required Color iconColor,
    required String path,
  }) {
    if (path.attachmentType.isImage) {
      return Hero(
        tag: 'chat-widget/$path',
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: isNetwork
                  ? CachedNetworkImageProvider(path) as ImageProvider
                  : FileImage(File(path)),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    } else if (path.attachmentType.isAudio) {
      return Icon(CupertinoIcons.music_note_2, color: iconColor, size: 28);
    } else if (path.attachmentType.isVideo) {
      return Icon(CupertinoIcons.play_arrow_solid, color: iconColor, size: 28);
    } else if (path.attachmentType.isGif) {
      return Icon(CupertinoIcons.photo, color: iconColor, size: 28);
    } else {
      return Icon(CupertinoIcons.doc_fill, color: iconColor, size: 28);
    }
  }
}

class AttachmentItem extends StatelessWidget {
  final void Function() onCancelTap;
  final String path;
  final bool isLoading;

  const AttachmentItem({
    super.key,
    required this.path,
    required this.onCancelTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AttachmentsTypeView(path: path),
        const SizedBox(width: 16),
        Flexible(
          child: Text(
            path.attachmentName,
            style: AppTextStyle.body2.copyWith(
              color: context.colorScheme.textSecondary,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (isLoading)
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: AppProgressIndicator(size: AppProgressIndicatorSize.small),
          ),
        actionButton(
          context,
          onPressed: onCancelTap,
          icon: Icon(
            Icons.cancel_rounded,
            color: context.colorScheme.textDisabled,
            size: 28,
          ),
        ),
      ],
    );
  }
}
