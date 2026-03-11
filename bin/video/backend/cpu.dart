part of video;

/// {@template test_media_generator.Cpu}
/// This defines the CPU backend, which uses software encoding and decoding.
///
/// https://en.wikipedia.org/wiki/Central_processing_unit
/// {@endtemplate}
class Cpu extends Backend {
  /// {@macro test_media_generator.Cpu}
  Cpu();

  @override
  String get name => 'cpu';

  @override
  bool get isAvailable => true;

  @override
  List<String> encoderFlags(String encoder) {
    switch (encoder) {
      case 'libaom-av1':
        return <String>[
          '-cpu-used',
          '$_cores',
          '-row-mt',
          '1',
          '-threads',
          '$_cores',
        ];
      case 'libvpx-vp9':
        return <String>['-row-mt', '1', '-threads', '$_cores'];
      case 'libx264':
        return <String>['-preset', 'veryfast', '-threads', '$_cores'];
      default:
        return const <String>[];
    }
  }

  int get _cores => Platform.numberOfProcessors;
}
