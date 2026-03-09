part of images;

/// Defines the configuration for the image generation process.
class Config {
  /// The output directory for the generated images.
  static final String outputDir = p.join('output', 'images');

  /// The path to the font file used for the text overlay.
  static final String fontPath = p.join('assets', 'fonts', 'DejaVuSans.ttf');

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
