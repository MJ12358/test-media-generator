part of images;

/// {@template test_media_generator.JPEG}
/// This defines the JPEG image codec,
/// which is a widely used lossy image format that has been around for decades.
///
/// https://en.wikipedia.org/wiki/JPEG
/// {@endtemplate}
class JPEG extends Codec {
  final String _name;
  final List<String> _encoderFlags;

  /// {@macro test_media_generator.JPEG}
  JPEG() : _name = 'jpeg', _encoderFlags = <String>['-q:v', '2'];

  /// {@macro test_media_generator.JPEG}
  ///
  /// This constructor creates a progressive JPEG.
  /// In which data is compressed in multiple passes of
  /// progressively higher detail.
  JPEG.progressive()
    : _name = 'jpeg_progressive',
      _encoderFlags = <String>['-progressive', '1', '-q:v', '2'];

  @override
  String get name => _name;

  @override
  String get extension => 'jpg';

  @override
  List<PixelFormat> get pixelFormats => <PixelFormat>[
    PixelFormat.yuv420p,
    PixelFormat.yuv422p,
    PixelFormat.yuv444p,
  ];

  @override
  List<String> get encoderFlags => _encoderFlags;
}
