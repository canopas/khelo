import 'package:flutter/material.dart';
import 'package:data/api/ball_score/ball_score_model.dart';
import 'dart:math';

import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class LinePainter extends CustomPainter {
  final Offset startOffset;
  Offset? endOffset;
  final double progress;
  final Color strokeColor;

  LinePainter({
    required this.startOffset,
    this.endOffset,
    required this.progress,
    required this.strokeColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (endOffset != null) {
      final paint = Paint()
        ..color = strokeColor
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 3.0;

      final currentOffset = Offset(
        startOffset.dx + (endOffset!.dx - startOffset.dx) * progress,
        startOffset.dy + (endOffset!.dy - startOffset.dy) * progress,
      );

      canvas.drawLine(startOffset, currentOffset, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class FieldingPositionsPainter extends CustomPainter {
  final BuildContext context;
  final double radius;
  final List<FieldingPosition> positions;
  final int divisions;

  final Paint _linePaint;

  FieldingPositionsPainter(
    this.context, {
    required this.radius,
    required this.positions,
    required this.divisions,
  }) : _linePaint = Paint()
          ..color = Colors.white
          ..strokeWidth = 0.7
          ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double angleStep = (2 * pi) / divisions;

    // Draw dividers
    for (int i = 0; i < divisions; i++) {
      final double angle = i * angleStep;
      final double startX = centerX + radius * cos(angle);
      final double startY = centerY + radius * sin(angle);
      final double endX = centerX + radius * cos(angle + pi);
      final double endY = centerY + radius * sin(angle + pi);
      canvas.drawLine(Offset(startX, startY), Offset(endX, endY), _linePaint);
    }

    final paint = Paint()
      ..color = context.colorScheme.secondary
      ..style = PaintingStyle.fill;

    final textStyle =
        AppTextStyle.caption.copyWith(color: context.colorScheme.textPrimary, fontWeight: FontWeight.normal);
    final textPainter = TextPainter(
      textAlign: TextAlign.right,
      textDirection: TextDirection.rtl,
      maxLines: 2,
    );

    // Draw fielding positions and labels
    for (var position in positions) {
      final positionAngle = (position.startAngle + position.endAngle) / 2;
      final angleRadians = positionAngle * pi / 180;
      double distance = radius;

      distance = radius - 50.0;

      final x = centerX + distance * cos(angleRadians);
      final y = centerY + distance * sin(angleRadians);

      // if (!position.isHeader) {
      canvas.drawCircle(Offset(x, y), 3, paint);
      // }

      textPainter.text = TextSpan(
        text: position.type.getString(context),
        style: textStyle,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(x - textPainter.width / 2, y + 10));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
