part of video;

/// {@template test_media_generator.MJPEG}
/// This defines the MJPEG video codec, which is a simple video format that
/// encodes each frame as a separate JPEG image.
///
/// https://en.wikipedia.org/wiki/Motion_JPEG
/// {@endtemplate}
class MJPEG extends Codec {
  /// {@macro test_media_generator.MJPEG}
  MJPEG();

  @override
  String get name => 'mjpeg';

  @override
  String get extension => 'avi';

  @override
  String get audio => 'pcm_s16le';

  @override
  /// MJPEG is a very simple codec that does not have hardware acceleration,
  /// so we use the same encoder for all backends.
  String get softwareEncoder => 'mjpeg';

  @override
  List<PixelFormat> get pixelFormats => <PixelFormat>[
    PixelFormat.yuvj420p,
    PixelFormat.yuvj422p,
    PixelFormat.yuvj444p,
  ];

  @override
  /// MJPEG is extremely inefficient, so we use restricted resolutions
  /// to keep file sizes manageable.
  List<Size> sizes(_) => <Size>[Size.s140, Size.s360, Size.s720, Size.s1080];

  @override
  /// These tunings are to prevent buffer over/under flows and packet too large errors.
  List<String> get tuning => <String>[
    '-q:v', '9', // Higher value = more compression
    '-b:v', '2M', // Add bitrate limit
    '-maxrate', '2M', // Maximum bitrate
    '-bufsize', '4M', // Buffer size for rate control
    '-compression_level', '100', // Maximum compression (if supported)
    '-quality', '2', // 0=fast, 1=best, 2=fastest compression
  ];
}
