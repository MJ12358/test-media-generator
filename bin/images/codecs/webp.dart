import 'codec.dart';

class WEBP extends Codec {
  final bool _lossless;
  final int _quality;

  WEBP._({required bool lossless, required int quality})
    : _lossless = lossless,
      _quality = quality;

  factory WEBP.lossy() {
    return WEBP._(lossless: false, quality: 75);
  }

  factory WEBP.lossless() {
    return WEBP._(lossless: true, quality: 100);
  }

  @override
  String get name {
    return _lossless ? 'webp_lossless' : 'webp_lossy';
  }

  @override
  String get extension => 'webp';

  @override
  String get pixelFormat {
    if (_lossless) {
      return 'rgba';
    } else {
      return 'rgb24';
    }
  }

  @override
  String get encoder => 'libwebp';

  @override
  List<String> get encoderFlags {
    if (_lossless) {
      return <String>['-lossless', '1', '-quality', _quality.toString()];
    } else {
      return <String>['-quality', _quality.toString()];
    }
  }
}
