part of audio;

/// {@template test_media_generator.ALAC}
/// This defines the ALAC audio codec,
/// which is a lossless audio format developed by Apple.
///
/// https://en.wikipedia.org/wiki/Apple_Lossless_Audio_Codec
/// {@endtemplate}
class ALAC extends Codec {
  /// {@macro test_media_generator.ALAC}
  ALAC();

  @override
  String get name => 'alac';

  @override
  String get extension => 'm4a';

  @override
  String get encoder => 'alac';
}
