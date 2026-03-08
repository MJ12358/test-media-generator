import 'codec.dart';

class AAC extends Codec {
  @override
  String get name => 'aac';

  @override
  String get extension => 'm4a';

  @override
  String get encoder => 'aac';

  @override
  /// AAC is lossy, but can encode from different bit depths.
  List<int> get bitDepths => <int>[16, 24];
}
