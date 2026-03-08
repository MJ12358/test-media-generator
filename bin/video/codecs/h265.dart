import 'codec.dart';

class H265 extends Codec {
  @override
  String get name => 'h265';

  @override
  String get extension => 'mp4';

  @override
  String get audio => 'aac';

  @override
  List<String> get tuning => <String>['-crf', '28', '-tag:v', 'hvc1'];
}
