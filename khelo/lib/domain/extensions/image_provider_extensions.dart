import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:palette_generator/palette_generator.dart';

extension ImageProviderExtension on ImageProvider {
  Future<PaletteGenerator> createPaletteGenerator() async {
    final provider = ResizeImage(this, width: 100, height: 100);

    final ImageStream stream =
        provider.resolve(const ImageConfiguration(devicePixelRatio: 1));

    final Completer<ui.Image> completer = Completer();
    ImageStreamListener? listener;

    listener = ImageStreamListener((ImageInfo imageInfo, _) {
      if (!completer.isCompleted) {
        completer.complete(imageInfo.image);
        stream.removeListener(listener!);
      }
    });

    stream.addListener(listener);

    final image = await completer.future;
    final byteData = await image.toByteData();

    final encoded =
        EncodedImage(byteData!, width: image.width, height: image.height);

    return await compute(_generatePalette, encoded);
  }

  Future<PaletteGenerator> _generatePalette(EncodedImage image) async {
    return await PaletteGenerator.fromByteData(image);
  }
}
