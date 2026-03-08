import '../backend/cpu.dart';
import '../video_generator.dart';
import 'codec.dart';

class AV1 extends Codec {
  @override
  String get name => 'av1';

  @override
  String get extension => 'mkv';

  @override
  String get audio => 'opus';

  @override
  List<String> get tuning => <String>['-b:v', '0', '-crf', '35'];

  @override
  List<String> get encoderFlags {
    if (VideoGenerator.backend is Cpu) {
      return <String>['-cpu-used', '4', '-row-mt', '1', '-threads', '4'];
    } else {
      return <String>[];
    }
  }
}
