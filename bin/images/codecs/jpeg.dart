part of images;

/// {@template test_media_generator.JPEG}
/// This defines the JPEG image codec,
/// which is a widely used lossy image format that has been around for decades.
///
/// https://en.wikipedia.org/wiki/JPEG
/// {@endtemplate}
class JPEG extends Codec {
  final bool _progressive;

  /// {@macro test_media_generator.JPEG}
  factory JPEG() {
    return JPEG._(progressive: false);
  }

  /// {@macro test_media_generator.JPEG}
  ///
  /// This constructor creates a progressive JPEG.
  /// In which data is compressed in multiple passes of
  /// progressively higher detail.
  factory JPEG.progressive() {
    return JPEG._(progressive: true);
  }

  JPEG._({required bool progressive}) : _progressive = progressive;

  @override
  String get name => _progressive ? 'jpeg_progressive' : 'jpeg';

  @override
  String get extension => 'jpg';

  @override
  List<String> get encoderFlags {
    if (_progressive) {
      return <String>['-progressive', '1', '-q:v', '2'];
    } else {
      return <String>['-q:v', '2'];
    }
  }
}
