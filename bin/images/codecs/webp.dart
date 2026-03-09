part of images;

/// {@template test_media_generator.WEBP}
/// This defines the WEBP image codec,
/// which is a modern image format that provides both lossy and
/// lossless compression, and is widely used for web images due
/// to its efficient compression and support for transparency.
///
/// https://en.wikipedia.org/wiki/WebP
/// {@endtemplate}
class WEBP extends Codec {
  final bool _lossless;
  final int _quality;

  /// {@macro test_media_generator.WEBP}
  ///
  /// This constructor defines a lossy WEBP configuration
  /// with a default quality of 75.
  factory WEBP.lossy() {
    return WEBP._(lossless: false, quality: 75);
  }

  /// {@macro test_media_generator.WEBP}
  ///
  /// This constructor defines a lossless WEBP configuration
  /// with a quality of 100.
  factory WEBP.lossless() {
    return WEBP._(lossless: true, quality: 100);
  }

  WEBP._({required bool lossless, required int quality})
    : _lossless = lossless,
      _quality = quality;

  @override
  String get name {
    return _lossless ? 'webp_lossless' : 'webp_lossy';
  }

  @override
  String get extension => 'webp';

  @override
  PixelFormat get pixelFormat {
    if (_lossless) {
      return PixelFormat.rgba;
    } else {
      return super.pixelFormat;
    }
  }

  @override
  String get encoder => 'libwebp';

  @override
  List<String> get encoderFlags {
    if (_lossless) {
      return <String>['-lossless', '1', '-quality', '$_quality'];
    } else {
      return <String>['-quality', '$_quality'];
    }
  }
}
