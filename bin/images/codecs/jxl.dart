import 'codec.dart';

class JXL extends Codec {
  @override
  String get name => 'jxl';

  @override
  String get extension => 'jxl';

  @override
  String get pixelFormat => 'rgb48le';

  @override
  String get encoder => 'libjxl';
}
