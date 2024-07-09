import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/widgets/custom_painters.dart';

class GroundLayoutView extends StatefulWidget {
  const GroundLayoutView({super.key});

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
  late Offset _startOffset; // Center of the ground (imaginary batsman position)
  Offset? _endOffset;
  bool _isAnimating = false;

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

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _isAnimating = false;
      }
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _endOffset = details.localPosition;
      _isAnimating = true;
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
      child: Stack(
        alignment: Alignment.center,
        children: [
          _groundCircle(),
          // AnimatedPositioned(
          //   width: positionIndicatorSize / 2,
          //   height: positionIndicatorSize / 2,
          //   left: (position?.dx ?? groundRadius),
          //   top: (position?.dy ?? groundRadius),
          //   duration: const Duration(milliseconds: 500),
          //   curve: Curves.fastOutSlowIn,
          //   child: CircleAvatar(
          //     backgroundColor: context.colorScheme.primary,
          //   ),
          // )
        ],
      ),
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
    setState(() {
      position = localPosition;
      _controller.forward();
    });
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
      child: Stack(
        children: [
          _boundaryCircle(),
          SizedBox(
            height: (groundRadius * 2),
            width: (groundRadius * 2),
            child: CustomPaint(
              painter: CircleDividerPainter(divisions: 8),
            ),
          ),
          GestureDetector(
            onTapUp: _onTapUp,
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
