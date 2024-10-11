import 'package:flutter/material.dart';
import 'package:style/extensions/context_extensions.dart';

class SliverPersistentDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  SliverPersistentDelegate({Key? key, required this.child});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: context.colorScheme.surface,
      alignment: Alignment.centerLeft,
      child: child,
    );
  }

  @override
  bool shouldRebuild(SliverPersistentDelegate oldDelegate) {
    return child != oldDelegate.child;
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;
}
