import 'package:flutter/material.dart';
import 'package:data/api/ball_score/ball_score_model.dart';
import 'dart:math';

import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class LinePainter extends CustomPainter {
  final Offset? endOffset;
  final double progress;
  final Color strokeColor;

  LinePainter({
    this.endOffset,
    required this.progress,
    required this.strokeColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Calculate the center of the widget
    final startOffset = Offset(size.width / 2, size.height / 2);

    if (endOffset != null) {
      final paint = Paint()
        ..color = strokeColor
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 3.0;

      // Calculate the currentOffset based on the progress
      final currentOffset = Offset(
        startOffset.dx + (endOffset!.dx - startOffset.dx) * progress,
        startOffset.dy + (endOffset!.dy - startOffset.dy) * progress,
      );

      // Draw the line from startOffset to currentOffset
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

    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    // Draw side labels
    for (var side in Side.values) {
      textPainter.text = TextSpan(
        text: side.getString(context),
        style: AppTextStyle.caption
            .copyWith(color: context.colorScheme.textPrimary),
      );

      drawLabelsAndPosition(
        canvas,
        paint,
        textPainter,
        centerX,
        centerY,
        angle: side.angle,
        distance: radius / 2,
        isHeader: true,
      );
    }

    // Draw fielding positions and labels
    for (var position in positions) {
      if (position.showOnScreen) {
        final positionAngle = (position.startAngle + position.endAngle) / 2;
        double distance = radius / position.distance.divisor;

        textPainter.text = TextSpan(
          text: position.type.getString(context),
          style: AppTextStyle.caption
              .copyWith(color: context.colorScheme.textSecondary),
        );

        drawLabelsAndPosition(
          canvas,
          paint,
          textPainter,
          centerX,
          centerY,
          angle: positionAngle,
          distance: distance,
          isHeader: false,
        );
      }
    }
  }

  void drawLabelsAndPosition(
    Canvas canvas,
    Paint paint,
    TextPainter textPainter,
    double centerX,
    double centerY, {
    required double distance,
    required double angle,
    required bool isHeader,
  }) {
    final radius = this.radius - 12;
    final angleRadians = angle * pi / 180;

    final x = centerX + distance * cos(angleRadians);
    final y = centerY + distance * sin(angleRadians);

    textPainter.layout(maxWidth: 70);

    final textWidth = textPainter.width;
    final textHeight = textPainter.height;

    // Adjust the position to ensure the text is inside the circle
    double adjustedX = x;
    double adjustedY = y;

    // Calculate the boundary check offsets
    if (adjustedX + textWidth / 2 > centerX + radius) {
      adjustedX = centerX + radius - textWidth / 2;
    } else if (adjustedX - textWidth / 2 < centerX - radius) {
      adjustedX = centerX - radius + textWidth / 2;
    }

    if (adjustedY + textHeight / 2 > centerY + radius) {
      adjustedY = centerY + radius - textHeight / 2;
    } else if (adjustedY - textHeight / 2 < centerY - radius) {
      adjustedY = centerY - radius + textHeight / 2;
    }

    if (!isHeader) {
      // draw position indicator
      canvas.drawCircle(Offset(x, y), 3, paint);
    }

    textPainter.paint(canvas, Offset(adjustedX - textWidth / 2, adjustedY + 1));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
