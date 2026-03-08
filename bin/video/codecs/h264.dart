import 'codec.dart';

class H264 extends Codec {
  @override
  String get name => 'h264';

  @override
  String get extension => 'mp4';

  @override
  String get audio => 'aac';

  @override
  List<String> get tuning => <String>['-crf', '23'];
}
