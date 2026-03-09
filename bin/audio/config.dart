part of audio;

/// Defines the configuration for the audio generation process.
class Config {
  /// The output directory for the generated audio files.
  static final String outputDir = p.join('output', 'audio');

  /// The duration of the generated audio in seconds.
  static const int duration = 5;

  /// The frequency of the sine wave audio in Hz.
  static const int sineFrequency = 440;

  /// The codecs to test. Each codec defines its own properties.
  static final List<Codec> codecs = <Codec>[
    AAC(),
    AC3(),
    ALAC(),
    FLAC(),
    MP3(),
    MP3.vbr(),
    Opus(),
    Vorbis(),
    WAV.bit16(),
    WAV.bit24(),
  ];
}
