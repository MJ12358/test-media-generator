import 'codec.dart';

class Opus extends Codec {
  @override
  String get name => 'opus';

  @override
  String get extension => 'ogg';

  @override
  String get encoder => 'libopus';

  @override
  List<int> get bitDepths => <int>[16, 24];

  @override
  /// Opus internally supports up to 48kHz.
  List<int> get sampleRates => <int>[8000, 12000, 16000, 24000, 48000];
}
