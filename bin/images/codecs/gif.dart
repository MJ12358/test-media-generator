part of images;

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
}
