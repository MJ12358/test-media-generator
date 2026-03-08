import 'codec.dart';

class AC3 extends Codec {
  @override
  String get name => 'ac3';

  @override
  String get extension => 'ac3';

  @override
  String get encoder => 'ac3';

  @override
  List<int> get bitDepths => <int>[16, 24];

  @override
  /// AC3 supports up to 5.1 (6 channels).
  List<int> get channels => <int>[1, 2, 6];
}
