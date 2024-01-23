import 'package:flutter/widgets.dart';

void runPostFrame(Function() block) {
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    block();
  });
}
