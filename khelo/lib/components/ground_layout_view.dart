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
  late Offset _startOffset;
  Offset? _endOffset;

  List<FieldingPosition> positions = [
    FieldingPosition(FieldingPositionType.deepMidWicket,
        startAngle: 0, endAngle: 45, distance: Distance.boundary),
    FieldingPosition(FieldingPositionType.longOn,
        startAngle: 45, endAngle: 90, distance: Distance.boundary),
    FieldingPosition(FieldingPositionType.longOff,
        startAngle: 90, endAngle: 135, distance: Distance.boundary),
    FieldingPosition(FieldingPositionType.deepCover,
        startAngle: 135, endAngle: 180, distance: Distance.boundary),
    FieldingPosition(FieldingPositionType.deepPoint,
        startAngle: 180, endAngle: 225, distance: Distance.boundary),
    FieldingPosition(FieldingPositionType.thirdMan,
        startAngle: 225, endAngle: 270, distance: Distance.boundary),
    FieldingPosition(FieldingPositionType.deepFineLeg,
        startAngle: 270, endAngle: 315, distance: Distance.boundary),
    FieldingPosition(FieldingPositionType.deepSquareLeg,
        startAngle: 315, endAngle: 360, distance: Distance.boundary),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _startOffset = Offset(groundRadius, groundRadius);
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  void _onTapUp(TapUpDetails details, Size size) {
    final localPosition = details.localPosition;
    final double dx = localPosition.dx - size.width / 2;
    final double dy = localPosition.dy - size.height / 2;
    final double distance = sqrt(dx * dx + dy * dy);
    final double angle = (atan2(dy, dx) + 2 * pi) % (2 * pi);

    final double radius = min(size.width / 2, size.height / 2);
    final double boundary = radius;
    final double thirtyYards = radius * 0.6;

    for (var position in positions) {
      final double effectiveRadius =
          position.distance == Distance.boundary ? boundary : thirtyYards;
      if (distance <= effectiveRadius &&
          angle >= position.startAngle &&
          angle < position.endAngle) {
        widget.onPositionSelect(position);
        break;
      }
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
    return CircleAvatar(
      radius: groundRadius,
      backgroundColor: Colors.green,
      child: Stack(
        children: [
          _boundaryCircle(),
          SizedBox(
            height: (groundRadius * 2),
            width: (groundRadius * 2),
            child: CustomPaint(
              painter: FieldingPositionsPainter(context,
                  positions: positions, divisions: 8, radius: groundRadius),
            ),
          ),
          GestureDetector(
            onTapUp: (details) => _onTapUp(details, context.size!),
            child: CustomPaint(
                painter: LinePainter(
                    startOffset: _startOffset,
                    endOffset: _endOffset,
                    progress: _animation.value,
                    strokeColor: context.colorScheme.primary),
                child: CircleAvatar(
                  radius: groundRadius,
                  backgroundColor: Colors.transparent,
                )),
          ),
        ],
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
        margin: EdgeInsets.only(top: (groundRadius / 3) * 0.4),
        width: pitchWidth,
        height: groundRadius / 3,
        child: ColoredBox(color: Colors.orange.shade100),
      ),
    );
  }
}
