part of images;

/// {@template test_media_generator.PNG}
/// This defines the PNG image codec,
/// which is a widely used lossless image format that supports transparency.
///
/// https://en.wikipedia.org/wiki/PNG
/// {@endtemplate}
class PNG extends Codec {
  final bool _is16Bit;
  final bool _isAlpha;

  /// {@macro test_media_generator.PNG}
  factory PNG() {
    return PNG._(is16Bit: false, isAlpha: false);
  }

  /// {@macro test_media_generator.PNG}
  ///
  /// This constructor creates a PNG with an alpha channel,
  /// which supports transparency.
  factory PNG.alpha() {
    return PNG._(is16Bit: false, isAlpha: true);
  }

  /// {@macro test_media_generator.PNG}
  ///
  /// This constructor creates a 16-bit PNG,
  /// which provides higher color depth.
  factory PNG.bit16() {
    return PNG._(is16Bit: true, isAlpha: false);
  }

  PNG._({required bool is16Bit, required bool isAlpha})
    : _is16Bit = is16Bit,
      _isAlpha = isAlpha;

  @override
  String get name {
    if (_is16Bit) {
      return 'png16';
    } else if (_isAlpha) {
      return 'png_alpha';
    } else {
      return 'png';
    }
  }

  @override
  String get extension => 'png';

  @override
  PixelFormat get pixelFormat {
    if (_is16Bit) {
      return PixelFormat.rgb48le;
    } else if (_isAlpha) {
      return PixelFormat.rgba;
    } else {
      return super.pixelFormat;
    }
  }
}
