import 'codec.dart';

class JPEG extends Codec {
  final bool _progressive;

  factory JPEG() {
    return JPEG._(progressive: false);
  }

  JPEG._({required bool progressive}) : _progressive = progressive;

  factory JPEG.progressive() {
    return JPEG._(progressive: true);
  }

  @override
  String get name => _progressive ? 'jpeg_progressive' : 'jpeg';

  @override
  String get extension => 'jpg';

  @override
  String get pixelFormat => 'rgb24';

  @override
  List<String> get encoderFlags {
    if (_progressive) {
      return <String>['-progressive', '1', '-q:v', '2'];
    } else {
      return <String>['-q:v', '2'];
    }
  }
}
