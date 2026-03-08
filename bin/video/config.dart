import 'backend/backend.dart';
import 'backend/cpu.dart';
import 'backend/intel.dart';
import 'backend/nvidia.dart';
import 'backend/vaapi.dart';
import 'codecs/codec.dart';
import 'codecs/h264.dart';
import 'codecs/h265.dart';
import 'codecs/mjpeg.dart';
import 'codecs/mpeg2.dart';
import 'codecs/vp9.dart';

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

  /// The resolutions to generate,
  /// mapped from a friendly name to the actual dimensions.
  static const Map<String, String> resolutions = <String, String>{
    '140p': '256x144',
    '360p': '640x360',
    '720p': '1280x720',
    '1080p': '1920x1080',
    '4K': '3840x2160',
    '8K': '7680x4320',
  };

  /// The framerates to generate.
  static const List<int> framerates = <int>[24, 30, 60];

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
