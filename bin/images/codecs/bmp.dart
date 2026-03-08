import 'codec.dart';

class BMP extends Codec {
  @override
  String get name => 'bmp';

  @override
  String get extension => 'bmp';

  @override
  String get pixelFormat => 'rgb24';
}
