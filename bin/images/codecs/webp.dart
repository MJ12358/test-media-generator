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
  final String _name;
  final List<String> _encoderFlags;
  final List<PixelFormat> _pixelFormats;

  /// {@macro test_media_generator.WEBP}
  ///
  /// This constructor defines a lossy WEBP configuration
  /// with a default quality of 75.
  WEBP.lossy()
    : _name = 'webp_lossy',
      _encoderFlags = <String>['-quality', '75'],
      _pixelFormats = <PixelFormat>[PixelFormat.yuv420p];

  /// {@macro test_media_generator.WEBP}
  ///
  /// This constructor defines a lossless WEBP configuration
  /// with a quality of 100.
  WEBP.lossless()
    : _name = 'webp_lossless',
      _encoderFlags = <String>['-lossless', '1', '-quality', '100'],
      _pixelFormats = <PixelFormat>[PixelFormat.rgb24, PixelFormat.rgba];

  @override
  String get name => _name;

  @override
  String get extension => 'webp';

  @override
  List<PixelFormat> get pixelFormats => _pixelFormats;

  @override
  String get encoder => 'libwebp';

  @override
  List<String> get encoderFlags => _encoderFlags;
}
