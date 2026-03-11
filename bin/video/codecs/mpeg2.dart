part of video;

/// {@template test_media_generator.MPEG2}
/// This defines the MPEG2 video codec, which is a widely used video coding
/// format that was popular for DVDs and digital television broadcasting.
///
/// https://en.wikipedia.org/wiki/MPEG-2
/// {@endtemplate}
class MPEG2 extends Codec {
  /// {@macro test_media_generator.MPEG2}
  MPEG2();

  @override
  String get name => 'mpeg2';

  @override
  String get extension => 'mpg';

  @override
  String get audio => 'mp2';

  @override
  /// MPEG2 is an older codec with limited hardware support,
  /// so we use the same encoder for all backends.
  String get softwareEncoder => 'mpeg2video';

  @override
  /// MPEG2 is extremely inefficient, so we use restricted resolutions
  /// to keep file sizes manageable.
  List<Size> get sizes => <Size>[
    Size.s140,
    Size.s360,
    Size.s720,
    Size.s1080,
    Size.s1440,
    Size.s2160,
  ];

  @override
  /// These tunings are to prevent buffer over/under flows and packet too large errors.
  List<String> get tuning => <String>[
    '-b:v', '2M', // Add bitrate limit
    '-minrate', '2M', // Minimum bitrate
    '-maxrate', '2M', // Maximum bitrate
    '-bufsize', '4M', // Buffer size for rate control
    '-g', '15', // Set GOP size to 15 frames (for better seeking)
  ];
}
