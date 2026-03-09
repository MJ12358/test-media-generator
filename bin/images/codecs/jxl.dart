part of images;

/// {@template test_media_generator.JXL}
/// This defines the JXL image codec,
/// which is a modern image format designed for high compression efficiency
/// and support for high dynamic range (HDR) images.
///
/// https://en.wikipedia.org/wiki/JPEG_XL
/// {@endtemplate}
class JXL extends Codec {
  /// {@macro test_media_generator.JXL}
  JXL();

  @override
  String get name => 'jxl';

  @override
  String get extension => 'jxl';

  @override
  PixelFormat get pixelFormat => PixelFormat.rgb48le;

  @override
  String get encoder => 'libjxl';
}
