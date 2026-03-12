part of video;

/// {@template test_media_generator.H265}
/// This defines the H265 video codec, which is a successor to H264 and offers
/// improved compression efficiency, especially for high-resolution video.
///
/// https://en.wikipedia.org/wiki/High_Efficiency_Video_Coding
///
/// https://trac.ffmpeg.org/wiki/Encode/H.265
/// {@endtemplate}
class H265 extends Codec {
  /// {@macro test_media_generator.H265}
  H265();

  @override
  String get name => 'h265';

  @override
  String get extension => 'mp4';

  @override
  String get audio => 'aac';

  @override
  Map<Type, String> get hardwareEncoders => <Type, String>{
    Intel: 'hevc_qsv',
    Nvidia: 'hevc_nvenc',
    Vaapi: 'hevc_vaapi',
  };

  @override
  String get softwareEncoder => 'libx265';

  @override
  /// H265 supports 10-bit color depth, so we can include 10-bit pixel formats.
  List<PixelFormat> get pixelFormats => <PixelFormat>[
    PixelFormat.yuv420p10,
    PixelFormat.yuv422p10,
    PixelFormat.yuv444p10,
  ];

  @override
  /// H265 is a highly efficient codec, so we can generate higher resolutions.
  /// Some hardware encoders have limitations on supported resolutions.
  List<Size> sizes(Backend backend) {
    if (backend is Nvidia || backend is Vaapi) {
      return <Size>[
        Size.s140,
        Size.s360,
        Size.s720,
        Size.s1080,
        Size.s1440,
        Size.s2160,
      ];
    } else {
      return super.sizes(backend);
    }
  }

  @override
  List<String> get tuning => <String>['-crf', '28', '-tag:v', 'hvc1'];
}
