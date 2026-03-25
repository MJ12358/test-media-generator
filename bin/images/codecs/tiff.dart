part of images;

/// {@template test_media_generator.TIFF}
/// This defines the TIFF image codec,
/// which is a flexible image format that can support various types
/// of compression and is often used in professional photography and publishing.
///
/// https://en.wikipedia.org/wiki/TIFF
/// {@endtemplate}
class TIFF extends Codec {
  /// {@macro test_media_generator.TIFF}
  TIFF();

  @override
  String get name => 'tiff';

  @override
  String get extension => 'tiff';

  @override
  List<PixelFormat> get pixelFormats => <PixelFormat>[
    PixelFormat.rgb24,
    PixelFormat.rgb48le,
    PixelFormat.rgba,
    PixelFormat.rgba64le,
  ];

  @override
  /// TIFF is an uncompressed format, so we use very low resolutions
  /// to keep file sizes manageable.
  List<Size> get sizes => <Size>[
    Size.s1,
    Size.s16,
    Size.s256,
    Size.s512,
    Size.s1080,
    Size.s1080v,
  ];
}
