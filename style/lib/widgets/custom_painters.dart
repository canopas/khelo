import 'package:flutter/material.dart';
import 'dart:math';

class CircleDividerPainter extends CustomPainter {
  final int divisions;
  final Paint _linePaint;

  CircleDividerPainter({required this.divisions})
      : _linePaint = Paint()
          ..color = Colors.white
          ..strokeWidth = 0.7
          ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2;
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double angleStep = (2 * pi) / divisions;

    for (int i = 0; i < divisions; i++) {
      final double angle = i * angleStep;
      final double startX = centerX + radius * cos(angle);
      final double startY = centerY + radius * sin(angle);
      final double endX = centerX + radius * cos(angle + pi);
      final double endY = centerY + radius * sin(angle + pi);
      canvas.drawLine(Offset(startX, startY), Offset(endX, endY), _linePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

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

// class FieldingPosition {
//   final String name;
//   final double startAngle;
//   final double endAngle;
//   final bool isInside30Meters;
//
//   FieldingPosition(
//       {required this.name, required this.startAngle, required this.endAngle, this.isInside30Meters = false});
// }
//
// class CricketGroundTouchWidget extends StatefulWidget {
//   final List<FieldingPosition> fieldingPositions;
//
//   CricketGroundTouchWidget({required this.fieldingPositions});
//
//   @override
//   _CricketGroundTouchWidgetState createState() => _CricketGroundTouchWidgetState();
// }
//
// class _CricketGroundTouchWidgetState extends State<CricketGroundTouchWidget> {
//   String? tappedPosition;
//
//   void _handleTap(Offset localPosition, Size size) {
//     final double dx = localPosition.dx - size.width / 2;
//     final double dy = localPosition.dy - size.height / 2;
//     final double distance = sqrt(dx * dx + dy * dy);
//     final double angle = (atan2(dy, dx) + 2 * pi) % (2 * pi);
//
//     final double radius = min(size.width / 2, size.height / 2);
//     final double boundary = radius;
//     final double thirtyYards = radius * 0.6;
//
//     for (var position in widget.fieldingPositions) {
//       final double effectiveRadius = position.isInside30Meters ? thirtyYards : boundary;
//       if (distance <= effectiveRadius && angle >= position.startAngle && angle < position.endAngle) {
//         setState(() {
//           tappedPosition = position.name;
//         });
//         break;
//       }
//     }
//
//     print('Tapped position: $tappedPosition');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTapUp: (details) {
//         _handleTap(details.localPosition, context.size!);
//       },
//       child: CustomPaint(
//         size: Size(300, 300), // Adjust size as needed
//         painter: CricketGroundPainter(widget.fieldingPositions),
//         child: Center(
//           child: Text(
//             tappedPosition ?? 'Tap a position',
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
// class CricketGroundPainter extends CustomPainter {
//   final List<FieldingPosition> fieldingPositions;
//
//   CricketGroundPainter(this.fieldingPositions);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2.0;
//
//     final double radius = min(size.width / 2, size.height / 2);
//     final Offset center = Offset(size.width / 2, size.height / 2);
//
//     // Draw full ground with green color
//     paint.color = Colors.green;
//     paint.style = PaintingStyle.fill;
//     canvas.drawCircle(center, radius, paint);
//
//     // Draw boundary with white stroke
//     paint.color = Colors.white;
//     paint.style = PaintingStyle.stroke;
//     canvas.drawCircle(center, radius, paint);
//
//     // Draw 30-yard circle with white dotted stroke
//     paint.color = Colors.white;
//     paint.style = PaintingStyle.stroke;
//     paint.strokeWidth = 1.0;
//
//     // Create dotted effect for 30-yard circle
//     final double thirtyYardRadius = radius * 0.6;
//     final int segments = 60;
//     for (int i = 0; i < segments; i++) {
//       final double startAngle = 2 * pi * i / segments;
//       final double endAngle = startAngle + (pi / segments);
//       canvas.drawArc(
//         Rect.fromCircle(center: center, radius: thirtyYardRadius),
//         startAngle,
//         endAngle - startAngle,
//         false,
//         paint,
//       );
//     }
//
//     // Draw pitch with brown color
//     paint.color = Colors.orange.shade100;
//     paint.style = PaintingStyle.fill;
//     final double pitchWidth = radius * 0.15;
//     final double pitchHeight = radius * 0.5;
//     canvas.drawRect(
//       Rect.fromCenter(center: center, width: pitchWidth, height: pitchHeight),
//       paint,
//     );
//
//     paint.style = PaintingStyle.fill;
//     for (var position in fieldingPositions) {
//       paint.color = Colors.yellow;
//
//       final double effectiveRadius = position.isInside30Meters ? thirtyYardRadius : radius;
//       final double textAngle = (position.startAngle + position.endAngle) / 2;
//       final Offset positionOffset = Offset(
//         center.dx + (effectiveRadius * 0.9) * cos(textAngle),
//         center.dy + (effectiveRadius * 0.9) * sin(textAngle),
//       );
//
//       // Draw yellow dot for fielding position
//       canvas.drawCircle(positionOffset, 4, paint);
//
//       // Draw position name
//       final textPainter = TextPainter(
//         text: TextSpan(
//           text: position.name,
//           style: TextStyle(color: Colors.yellow, fontSize: 10),
//         ),
//         textDirection: TextDirection.ltr,
//       );
//
//       textPainter.layout(minWidth: 0, maxWidth: size.width);
//
//       final Offset textOffset = Offset(
//         positionOffset.dx - textPainter.width / 2,
//         positionOffset.dy - textPainter.height / 2,
//       );
//
//       textPainter.paint(canvas, textOffset);
//     }
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }
