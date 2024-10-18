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
  final String path;
  final bool isNetwork;

  const AttachmentsTypeView({
    super.key,
    required this.path,
    this.isNetwork = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: context.colorScheme.containerNormal,
        borderRadius: BorderRadius.circular(12),
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
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: isNetwork
                ? CachedNetworkImageProvider(path) as ImageProvider
                : FileImage(File(path)),
            fit: BoxFit.cover,
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
  final VoidCallback onCancelTap;
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
        Expanded(
          child: Text(
            path.attachmentName,
            style: AppTextStyle.body2.copyWith(
              color: context.colorScheme.textSecondary,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (isLoading) ...[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: AppProgressIndicator(size: AppProgressIndicatorSize.small),
          ),
        ] else ...[
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
      ],
    );
  }
}
