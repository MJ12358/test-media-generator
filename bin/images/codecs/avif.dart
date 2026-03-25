part of images;

/// {@template test_media_generator.AVIF}
/// This file defines the AVIF image codec,
/// which is a modern image format based on the AV1 video codec.
///
/// https://en.wikipedia.org/wiki/AVIF
/// {@endtemplate}
class AVIF extends Codec {
  /// {@macro test_media_generator.AVIF}
  AVIF();

  @override
  String get name => 'avif';

  @override
  String get extension => 'avif';

  @override
  String get encoder => 'libaom-av1';

  @override
  /// AVIF is YUV-based, so we can include YUV pixel formats.
  List<PixelFormat> get pixelFormats => <PixelFormat>[
    PixelFormat.yuv420p,
    PixelFormat.yuv422p,
    PixelFormat.yuv444p,
  ];

  @override
  List<String> get encoderFlags => <String>[
    '-still-picture',
    '1',
    '-crf',
    '30',
  ];
}
