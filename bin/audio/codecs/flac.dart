part of audio;

/// {@template test_media_generator.FLAC}
/// This defines the FLAC audio codec,
/// which is a widely used lossless audio format.
///
/// https://en.wikipedia.org/wiki/FLAC
/// {@endtemplate}
class FLAC extends Codec {
  /// {@macro test_media_generator.FLAC}
  FLAC();

  @override
  String get name => 'flac';

  @override
  String get extension => 'flac';

  @override
  String get encoder => 'flac';

  @override
  /// FLAC is lossless compression.
  ///
  /// We use this so that the generator can use this codec.
  List<BitRate> get bitRates => <BitRate>[BitRate.br320];
}
