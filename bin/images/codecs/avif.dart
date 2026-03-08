import 'codec.dart';

class AVIF extends Codec {
  @override
  String get name => 'avif';

  @override
  String get extension => 'avif';

  @override
  String get pixelFormat => 'rgb24';

  @override
  String get encoder => 'libaom-av1';

  @override
  List<String> get encoderFlags => <String>[
    '-still-picture',
    '1',
    '-crf',
    '30',
  ];
}
