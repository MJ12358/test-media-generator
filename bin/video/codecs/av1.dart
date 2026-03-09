part of video;

/// {@template test_media_generator.AV1}
/// This defines the AV1 video codec, which is an open and royalty-free
/// video coding format designed for efficient video compression.
///
/// https://en.wikipedia.org/wiki/AV1
/// {@endtemplate}
class AV1 extends Codec {
  /// {@macro test_media_generator.AV1}
  AV1();

  @override
  String get name => 'av1';

  @override
  String get extension => 'mkv';

  @override
  String get audio => 'opus';

  @override
  List<String> get encoderFlags {
    if (VideoGenerator.backend is Cpu) {
      return <String>['-cpu-used', '4', '-row-mt', '1', '-threads', '4'];
    } else {
      return <String>[];
    }
  }

  @override
  List<String> get tuning => <String>['-b:v', '0', '-crf', '35'];
}
