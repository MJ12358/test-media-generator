part of audio;

/// {@template test_media_generator.audio.AudioSpec}
/// This class represents the specifications for generating a test audio file.
/// {@endtemplate}
class AudioSpec {
  final Codec codec;
  final BitDepth bitDepth;
  final BitRate bitRate;
  final ChannelLayout channels;
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
