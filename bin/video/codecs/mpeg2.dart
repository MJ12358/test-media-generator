import 'codec.dart';

class MPEG2 extends Codec {
  @override
  String get name => 'mpeg2';

  @override
  String get extension => 'mpg';

  @override
  String get audio => 'mp2';

  @override
  List<String> get tuning => <String>[
    '-b:v',
    '8M',
    '-minrate',
    '8M',
    '-maxrate',
    '8M',
    '-bufsize',
    '1835k',
    '-g',
    '15',
  ];
}
