part of images;

/// {@template test_media_generator.TIFF}
/// This defines the TIFF image codec,
/// which is a flexible image format that can support various types
/// of compression and is often used in professional photography and publishing.
///
/// https://en.wikipedia.org/wiki/TIFF
/// {@endtemplate}
class TIFF extends Codec {
  /// {@macro test_media_generator.TIFF}
  TIFF();

  @override
  String get name => 'tiff';

  @override
  String get extension => 'tiff';

  @override
  PixelFormat get pixelFormat => PixelFormat.rgb48le;
}
