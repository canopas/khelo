/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/batsman.svg
  String get batsman => 'assets/images/batsman.svg';

  /// File path: assets/images/bowler.svg
  String get bowler => 'assets/images/bowler.svg';

  /// File path: assets/images/ic_arrow_down.svg
  String get icArrowDown => 'assets/images/ic_arrow_down.svg';

  /// File path: assets/images/ic_bat_selected.svg
  String get icBatSelected => 'assets/images/ic_bat_selected.svg';

  /// File path: assets/images/ic_batsman.png
  AssetGenImage get icBatsman =>
      const AssetGenImage('assets/images/ic_batsman.png');

  /// File path: assets/images/ic_bin.svg
  String get icBin => 'assets/images/ic_bin.svg';

  /// File path: assets/images/ic_bowler.png
  AssetGenImage get icBowler =>
      const AssetGenImage('assets/images/ic_bowler.png');

  /// File path: assets/images/ic_camera.png
  AssetGenImage get icCamera =>
      const AssetGenImage('assets/images/ic_camera.png');

  /// File path: assets/images/ic_check.svg
  String get icCheck => 'assets/images/ic_check.svg';

  /// File path: assets/images/ic_edit.svg
  String get icEdit => 'assets/images/ic_edit.svg';

  /// File path: assets/images/ic_gallery.png
  AssetGenImage get icGallery =>
      const AssetGenImage('assets/images/ic_gallery.png');

  /// File path: assets/images/ic_leather_ball.png
  AssetGenImage get icLeatherBall =>
      const AssetGenImage('assets/images/ic_leather_ball.png');

  /// File path: assets/images/ic_location.svg
  String get icLocation => 'assets/images/ic_location.svg';

  /// File path: assets/images/ic_micro_phone.png
  AssetGenImage get icMicroPhone =>
      const AssetGenImage('assets/images/ic_micro_phone.png');

  /// File path: assets/images/ic_other_ball.png
  AssetGenImage get icOtherBall =>
      const AssetGenImage('assets/images/ic_other_ball.png');

  /// File path: assets/images/ic_other_official.png
  AssetGenImage get icOtherOfficial =>
      const AssetGenImage('assets/images/ic_other_official.png');

  /// File path: assets/images/ic_profile.svg
  String get icProfile => 'assets/images/ic_profile.svg';

  /// File path: assets/images/ic_profile_thin.svg
  String get icProfileThin => 'assets/images/ic_profile_thin.svg';

  /// File path: assets/images/ic_scorer.png
  AssetGenImage get icScorer =>
      const AssetGenImage('assets/images/ic_scorer.png');

  /// File path: assets/images/ic_streamer.png
  AssetGenImage get icStreamer =>
      const AssetGenImage('assets/images/ic_streamer.png');

  /// File path: assets/images/ic_tennis_ball.png
  AssetGenImage get icTennisBall =>
      const AssetGenImage('assets/images/ic_tennis_ball.png');

  /// File path: assets/images/ic_umpire.png
  AssetGenImage get icUmpire =>
      const AssetGenImage('assets/images/ic_umpire.png');

  /// File path: assets/images/intro_cricket_dark.svg
  String get introCricketDark => 'assets/images/intro_cricket_dark.svg';

  /// File path: assets/images/intro_cricket_light.svg
  String get introCricketLight => 'assets/images/intro_cricket_light.svg';

  /// List of all assets
  List<dynamic> get values => [
        batsman,
        bowler,
        icArrowDown,
        icBatSelected,
        icBatsman,
        icBin,
        icBowler,
        icCamera,
        icCheck,
        icEdit,
        icGallery,
        icLeatherBall,
        icLocation,
        icMicroPhone,
        icOtherBall,
        icOtherOfficial,
        icProfile,
        icProfileThin,
        icScorer,
        icStreamer,
        icTennisBall,
        icUmpire,
        introCricketDark,
        introCricketLight
      ];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size = null});

  final String _assetName;

  final Size? size;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
