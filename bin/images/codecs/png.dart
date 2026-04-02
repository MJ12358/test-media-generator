part of images;

/// {@template test_media_generator.PNG}
/// This defines the PNG image codec,
/// which is a widely used lossless image format that supports transparency.
///
/// https://en.wikipedia.org/wiki/PNG
/// {@endtemplate}
class PNG extends Codec {
  final String _name;
  final List<PixelFormat> _pixelFormats;

  /// {@macro test_media_generator.PNG}
  PNG() : _name = 'png', _pixelFormats = <PixelFormat>[PixelFormat.rgb24];

  /// {@macro test_media_generator.PNG}
  ///
  /// This constructor creates a PNG with an alpha channel,
  /// which supports transparency.
  PNG.alpha()
    : _name = 'png_alpha',
      _pixelFormats = <PixelFormat>[PixelFormat.rgba];

  /// {@macro test_media_generator.PNG}
  ///
  /// This constructor creates a 16-bit PNG,
  /// which provides higher color depth.
  PNG.bit16()
    : _name = 'png16',
      _pixelFormats = <PixelFormat>[PixelFormat.rgb48le];

  /// {@macro test_media_generator.PNG}
  ///
  /// This constructor creates a 16-bit PNG with an alpha channel,
  /// which provides higher color depth and supports transparency.
  PNG.bit16Alpha()
    : _name = 'png16_alpha',
      _pixelFormats = <PixelFormat>[PixelFormat.rgba64le];

  @override
  String get name => _name;

  @override
  String get extension => 'png';

  @override
  List<PixelFormat> get pixelFormats => _pixelFormats;
}
