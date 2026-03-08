import 'codec.dart';

class TIFF extends Codec {
  @override
  String get name => 'tiff';

  @override
  String get extension => 'tiff';

  @override
  String get pixelFormat => 'rgb48le';
}
