import 'codec.dart';

class ALAC extends Codec {
  @override
  String get name => 'alac';

  @override
  String get extension => 'm4a';

  @override
  String get encoder => 'alac';
}
