import 'codec.dart';

class PNG extends Codec {
  final bool _is16Bit;
  final bool _isAlpha;

  factory PNG() {
    return PNG._(is16Bit: false, isAlpha: false);
  }

  PNG._({required bool is16Bit, required bool isAlpha})
    : _is16Bit = is16Bit,
      _isAlpha = isAlpha;

  factory PNG.alpha() {
    return PNG._(is16Bit: false, isAlpha: true);
  }

  factory PNG.bit16() {
    return PNG._(is16Bit: true, isAlpha: false);
  }

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
  String get pixelFormat {
    if (_is16Bit) {
      return 'rgb48le';
    } else if (_isAlpha) {
      return 'rgba';
    } else {
      return 'rgb24';
    }
  }
}
