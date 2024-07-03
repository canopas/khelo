import 'dart:math';
import 'package:flutter/material.dart';
import 'package:style/widgets/circle_divider_painter.dart';

class GroundLayoutView extends StatelessWidget {
  final double size = 184;
  final double groundRadius = 184;
  final double pitchWidth = 25;

  const GroundLayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _groundCircle(),
        SizedBox(
          height: (groundRadius * 2) - 27,
          width: (groundRadius * 2) - 27,
          child: GestureDetector(
            onTapUp: (details) {
              print("detail: ${details.localPosition}");
              _handleTap(details.localPosition, context.size!);
            },
            child: CustomPaint(
              painter: CircleDividerPainter(divisions: 8),
            ),
          ),
        ),
      ],
    );
  }

  void _handleTap(Offset localPosition, Size size) {
    final double dx = localPosition.dx - size.width / 2;
    final double dy = localPosition.dy - size.height / 2;
    final double distance = sqrt(dx * dx + dy * dy);
    final double angle = (atan2(dy, dx) + 2 * pi) % (2 * pi);

    final double radius = min(size.width / 2, size.height / 2);
    final double boundary = radius;
    final double thirtyYards = radius * 0.6;

    // for (var position in widget.fieldingPositions) {
    //   final double effectiveRadius =
    //       position.isInside30Meters ? thirtyYards : boundary;
    //   if (distance <= effectiveRadius &&
    //       angle >= position.startAngle &&
    //       angle < position.endAngle) {
    //     setState(() {
    //       tappedPosition = position.name;
    //     });
    //     break;
    //   }
    // }
  }

  Widget _groundCircle() {
    return CircleAvatar(
      radius: groundRadius,
      backgroundColor: Colors.green,
      child: _boundaryCircle(),
    );
  }

  Widget _boundaryCircle() {
    return Container(
      margin: const EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white, // Stroke color
          width: 1.5,
        ),
      ),
      child: _pitch(),
    );
  }

  Widget _pitch() {
    return CircleAvatar(
      radius: groundRadius / 2,
      backgroundColor: Colors.lightGreen,
      child: Container(
        margin: EdgeInsets.only(top: (groundRadius / 3) * 0.4),
        width: pitchWidth,
        height: groundRadius / 3,
        child: ColoredBox(color: Colors.orange.shade100),
      ),
    );
  }
}