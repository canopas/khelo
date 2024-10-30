import 'package:flutter/widgets.dart';

void runPostFrame(VoidCallback block) {
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    block();
  });
}
