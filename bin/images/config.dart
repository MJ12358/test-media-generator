part of images;

/// Defines the configuration for the image generation process.
class Config {
  /// The output directory for the generated images.
  static const String outputDir = '../output/images';

  /// The path to the font file used for the text overlay.
  static const String fontPath = '../assets/fonts/DejaVuSans.ttf';

  /// The resolutions to generate,
  /// mapped from a friendly name to the actual dimensions.
  static const List<Size> sizes = <Size>[
    Size.s1,
    Size.s16,
    Size.s256,
    Size.s512,
    Size.s1080,
    Size.s2160,
    Size.s4320,
    Size.odd,
    Size.extreme,
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
