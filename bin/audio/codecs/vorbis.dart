import 'codec.dart';

class Vorbis extends Codec {
  @override
  String get name => 'vorbis';

  @override
  String get extension => 'ogg';

  @override
  String get encoder => 'libvorbis';

  @override
  List<int> get bitDepths => <int>[16, 24, 32];

  @override
  List<String> get encoderFlags => <String>['-q:a', '5'];
}
