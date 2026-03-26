part of audio;

/// {@template test_media_generator.audio.AudioSpec}
/// This class represents the specifications for generating a test audio file.
/// {@endtemplate}
class AudioSpec {
  /// {@macro test_media_generator.audio.Codec}
  final Codec codec;

  /// {@macro test_media_generator.audio.BitDepth}
  final BitDepth bitDepth;

  /// {@macro test_media_generator.audio.BitRate}
  final BitRate bitRate;

  /// {@macro test_media_generator.audio.ChannelLayout}
  final ChannelLayout channels;

  /// {@macro test_media_generator.audio.SampleRate}
  final SampleRate sampleRate;

  /// {@macro test_media_generator.audio.AudioSpec}
  AudioSpec({
    required this.codec,
    required this.bitDepth,
    required this.bitRate,
    required this.channels,
    required this.sampleRate,
  });
}
