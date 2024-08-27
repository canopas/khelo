import 'package:flutter/cupertino.dart';
import 'package:style/button/bottom_sticky_overlay.dart';
import 'package:style/extensions/context_extensions.dart';

class BottomSheetWrapper extends StatelessWidget {
  final Widget content;
  final bool showDragHandle;
  final double? height;
  final double contentBottomSpacing;
  final List<Widget> action;
  final List<Widget>? options;

  const BottomSheetWrapper({
    super.key,
    this.showDragHandle = true,
    this.contentBottomSpacing = 70,
    this.height,
    required this.content,
    required this.action,
    this.options,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      constraints:
          BoxConstraints(maxHeight: context.mediaQuerySize.height * 0.8),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: IntrinsicHeight(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: showDragHandle ? 44 : 0),
              child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0) +
                      EdgeInsets.only(bottom: contentBottomSpacing) +
                      context.mediaQueryPadding +
                      BottomStickyOverlay.padding,
                  child: content),
            ),
            if (showDragHandle) ...[
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 4,
                  width: 32,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                      color: context.colorScheme.outline,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
            BottomStickyOverlay(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...?options,
                  Row(
                    children: [
                      for (int i = 0; i < action.length; i++) ...[
                        Expanded(child: action[i]),
                        if (i < action.length - 1) const SizedBox(width: 16),
                      ]
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
