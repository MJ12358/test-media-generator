import 'codec.dart';

class FLAC extends Codec {
  @override
  String get name => 'flac';

  @override
  String get extension => 'flac';

  @override
  String get encoder => 'flac';

  @override
  /// FLAC is lossless compression.
  List<int> get bitRates => <int>[];
}
