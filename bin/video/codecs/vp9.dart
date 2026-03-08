import 'codec.dart';

class VP9 extends Codec {
  @override
  String get name => 'vp9';

  @override
  String get extension => 'webm';

  @override
  String get audio => 'libopus';

  @override
  List<String> get tuning => <String>['-b:v', '0', '-crf', '32'];
}
