import 'codec.dart';

class GIF extends Codec {
  @override
  String get name => 'gif';

  @override
  String get extension => 'gif';

  @override
  String get pixelFormat => 'rgb24';
}
