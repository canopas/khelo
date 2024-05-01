import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';

const _bufferTimeMillis = Duration(milliseconds: 300);

enum AppProgressIndicatorSize { small, normal }

class AppProgressIndicator extends StatefulWidget {
  final double? radius;
  final AppProgressIndicatorSize? size;
  final Color? color;

  const AppProgressIndicator({
    Key? key,
    this.radius,
    AppProgressIndicatorSize? size,
    this.color,
  })  : assert(radius == null || size == null,
            "Cannot provide both a radius and a size."),
        size = radius == null ? size ?? AppProgressIndicatorSize.normal : null,
        super(key: key);

  @override
  State<AppProgressIndicator> createState() => _AppProgressIndicatorState();
}

class _AppProgressIndicatorState extends State<AppProgressIndicator> {
  bool _showProgress = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(_bufferTimeMillis).then((_) {
      if (mounted) {
        setState(() => _showProgress = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _showProgress ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: _indicator(),
    );
  }

  Widget _indicator() {
    final radius = widget.radius ??
        (widget.size == AppProgressIndicatorSize.small ? 10.0 : 16.0);

    if (Platform.isIOS) {
      return CupertinoActivityIndicator(
        color: widget.color ?? context.colorScheme.primary,
        radius: radius,
      );
    } else {
      return Center(
        child: SizedBox(
          width: radius * 1.8,
          height: radius * 1.8,
          child: CircularProgressIndicator(
            color: widget.color ?? context.colorScheme.primary,
          ),
        ),
      );
    }
  }
}