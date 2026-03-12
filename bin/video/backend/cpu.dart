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
          '4', // speed/quality tradeoff level
          '-row-mt',
          '1',
          '-threads',
          '$_threads',
        ];
      case 'libvpx-vp9':
        return <String>['-row-mt', '1', '-threads', '$_threads'];
      case 'libx264':
        return <String>['-preset', 'veryfast', '-threads', '$_threads'];
      default:
        return const <String>[];
    }
  }

  /// The number of CPU cores available,
  /// used to determine the number of threads for encoding.
  int get _cores => Platform.numberOfProcessors;

  /// The number of threads to use for encoding,
  /// which is typically one less than the total number
  /// of CPU cores to avoid overloading the system.
  int get _threads => _cores > 1 ? _cores - 1 : 1;
}
