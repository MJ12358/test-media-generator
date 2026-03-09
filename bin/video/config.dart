part of video;

/// Defines the configuration for the video generation process.
class Config {
  /// The output directory for the generated videos.
  static const String outputDir = '../output/videos';

  /// The duration of the generated video in seconds.
  static const int duration = 5;

  /// The frequency of the sine wave audio in Hz.
  static const int sineFrequency = 440;

  /// The path to the font file used for the text overlay.
  static const String fontPath = '../assets/fonts/DejaVuSans.ttf';

  /// The backends to test. Each backend defines its own properties.
  /// The `detect` method in the [Backend] class will determine which backend
  /// is available on the current system and select it for encoding.
  static final List<Backend> backends = <Backend>[
    Nvidia(),
    Intel(),
    Vaapi(),
    Cpu(),
  ];

  /// The codecs to test. Each [Codec] defines its own properties
  /// such as the file extension, audio codec, and tuning parameters.
  static final List<Codec> codecs = <Codec>[
    H264(),
    H265(),
    VP9(),
    // AV1(), // Uncomment when ready
    MJPEG(),
    MPEG2(),
  ];
}
