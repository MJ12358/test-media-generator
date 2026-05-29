part of '../images.dart';

/// {@template test_media_generator.GIF}
/// This defines the GIF image codec,
/// which is a widely used bitmap image format that supports animations.
///
/// https://en.wikipedia.org/wiki/GIF
/// {@endtemplate}
class GIF extends Codec {
  /// {@macro test_media_generator.GIF}
  GIF();

  @override
  String get name => 'gif';

  @override
  String get extension => 'gif';

  @override
  /// GIF uses the PAL8 pixel format.
  List<PixelFormat> get pixelFormats => <PixelFormat>[PixelFormat.pal8];
}
