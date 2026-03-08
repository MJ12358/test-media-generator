import 'codec.dart';

class MJPEG extends Codec {
  @override
  String get name => 'mjpeg';

  @override
  String get extension => 'avi';

  @override
  String get audio => 'pcm_s16le';

  @override
  List<String> get tuning => <String>['-q:v', '3'];

  @override
  List<String> get pixelFormats => <String>['yuvj420p', 'yuvj422p', 'yuvj444p'];
}
