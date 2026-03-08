import 'codecs/avif.dart';
import 'codecs/bmp.dart';
import 'codecs/codec.dart';
import 'codecs/gif.dart';
import 'codecs/jpeg.dart';
import 'codecs/jxl.dart';
import 'codecs/png.dart';
import 'codecs/tiff.dart';
import 'codecs/webp.dart';

/// Defines the configuration for the image generation process.
class Config {
  /// The output directory for the generated images.
  static const String outputDir = '../output/images';

  /// The path to the font file used for the text overlay.
  static const String fontPath = '../assets/fonts/DejaVuSans.ttf';

  /// The resolutions to generate,
  /// mapped from a friendly name to the actual dimensions.
  static const List<String> sizes = <String>[
    '1x1',
    '16x16',
    '256x256',
    '512x512',
    '1920x1080', // 1080p
    '3840x2160', // 4K
    '7680x4320', // 8K
    '257x509', // Odd / prime dimensions
    '4096x256', // Extreme aspect ratio
  ];

  /// The codecs to test. Each codec defines its own properties.
  static final List<Codec> codecs = <Codec>[
    JPEG(),
    // JPEG.progressive(),
    PNG(),
    PNG.alpha(),
    PNG.bit16(),
    WEBP.lossy(),
    WEBP.lossless(),
    BMP(),
    TIFF(),
    GIF(),
    AVIF(),
    JXL(),
  ];
}
