import 'dart:math';
import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:flutter/material.dart';
import 'package:khelo/components/custom_painters.dart';
import 'package:style/extensions/context_extensions.dart';

class GroundLayoutView extends StatefulWidget {
  final Function(FieldingPosition) onPositionSelect;

  const GroundLayoutView({super.key, required this.onPositionSelect});

  @override
  State<GroundLayoutView> createState() => _GroundLayoutViewState();
}

class _GroundLayoutViewState extends State<GroundLayoutView>
    with SingleTickerProviderStateMixin {
  final double groundRadius = 184;
  final double pitchWidth = 25;
  final double positionIndicatorSize = 10;
  Offset? position;

  late AnimationController _controller;
  late Animation<double> _animation;
  Offset? _endOffset;

  List<FieldingPosition> positions = [
    FieldingPosition(
      FieldingPositionType.deepMidWicket,
      startAngle: 0,
      endAngle: 45,
    ),
    FieldingPosition(
      FieldingPositionType.longOn,
      startAngle: 45,
      endAngle: 90,
    ),
    FieldingPosition(
      FieldingPositionType.longOff,
      startAngle: 90,
      endAngle: 135,
    ),
    FieldingPosition(
      FieldingPositionType.deepCover,
      startAngle: 135,
      endAngle: 180,
    ),
    FieldingPosition(
      FieldingPositionType.deepPoint,
      startAngle: 180,
      endAngle: 225,
    ),
    FieldingPosition(
      FieldingPositionType.thirdMan,
      startAngle: 225,
      endAngle: 270,
    ),
    FieldingPosition(
      FieldingPositionType.deepFineLeg,
      startAngle: 270,
      endAngle: 315,
    ),
    FieldingPosition(
      FieldingPositionType.deepSquareLeg,
      startAngle: 315,
      endAngle: 360,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  FieldingPosition? _getSelectedPosition(double angle, double distance) {
    final filteredPositions = positions
        .where((position) =>
            angle >= position.startAngle && angle < position.endAngle)
        .toList();

    FieldingPosition? selectedPosition;
    double smallestDistanceDifference = double.infinity;
    filteredPositions
        .sort((a, b) => a.distance.index.compareTo(b.distance.index));
    for (var position in filteredPositions) {
      final double effectiveRadius = groundRadius / position.distance.divisor;
      final double distanceDifference = (effectiveRadius - distance).abs();

      if (distance <= effectiveRadius) {
        selectedPosition = position;
        break;
      } else if (distanceDifference < smallestDistanceDifference) {
        selectedPosition = position;
        smallestDistanceDifference = distanceDifference;
      }
    }
    return selectedPosition;
  }

  void _onTapUp(TapUpDetails details, Size size) {
    final localPosition = details.localPosition;
    final double dx = localPosition.dx - size.width / 2;
    final double dy = localPosition.dy - size.height / 2;
    final double distance = sqrt(dx * dx + dy * dy);
    final double angle = (atan2(dy, dx) * (180 / pi) + 360) % 360;

    FieldingPosition? selectedPosition = _getSelectedPosition(angle, distance);

    if (selectedPosition != null) {
      widget.onPositionSelect(selectedPosition);
    }

    setState(() {
      _endOffset = details.localPosition;
      _controller.reset();
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: groundRadius,
      child: _groundCircle(),
    );
  }

  Widget _groundCircle() {
    return GestureDetector(
      onTapUp: (details) => _onTapUp(details, context.size!),
      child: CircleAvatar(
        radius: groundRadius,
        backgroundColor: Colors.green,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _boundaryCircle(),
            CustomPaint(
              painter: FieldingPositionsPainter(context,
                  positions: positions,
                  divisions: 8,
                  radius: groundRadius - 15),
            ),
            CustomPaint(
                painter: LinePainter(
                    endOffset: _endOffset,
                    progress: _animation.value,
                    strokeColor: context.colorScheme.primary),
                child: CircleAvatar(
                  radius: groundRadius,
                  backgroundColor: Colors.transparent,
                )),
          ],
        ),
      ),
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
        margin: EdgeInsets.only(top: (groundRadius / 3) * 0.7),
        width: pitchWidth,
        height: groundRadius / 3,
        child: ColoredBox(color: Colors.orange.shade100),
      ),
    );
  }
}
