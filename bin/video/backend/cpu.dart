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
}
