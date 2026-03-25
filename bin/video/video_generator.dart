part of video;

class VideoSpec {
  final Codec codec;
  final Size size;
  final FrameRate frameRate;
  final PixelFormat pixelFormat;

  VideoSpec({
    required this.codec,
    required this.size,
    required this.frameRate,
    required this.pixelFormat,
  });
}

/// {@template test_media_generator.VideoGenerator}
/// This class is responsible for generating test video files.
/// {@endtemplate}
class VideoGenerator extends Generator<VideoSpec> {
  /// {@macro test_media_generator.video.Backend}
  static late Backend backend;
  late final int duration;
  late final int sineFrequency;
  late final String fontPath;

  /// {@macro test_media_generator.VideoGenerator}
  VideoGenerator() : super(outputDir: Config.outputDir) {
    backend = Backend.detect();
    duration = Config.duration;
    sineFrequency = Config.sineFrequency;
    fontPath = Config.fontPath;
  }

  String _getSource(Size size, FrameRate frameRate) {
    return <String>[
      'testsrc=duration=$duration',
      'size=${size.value}',
      'rate=${frameRate.value}',
    ].join(':');
  }

  String _getVideoFilter(Size size, FrameRate frameRate, String filename) {
    final String src = _getSource(size, frameRate);
    final String text = DrawTextBuilder.build(
      fontPath: fontPath,
      text: filename,
      height: size.height,
      width: size.width,
    );
    return '$src,drawtext=$text';
  }

  @override
  String getFileName(VideoSpec spec) {
    return '${spec.codec.name}_'
        '${spec.size.value}_'
        '${spec.frameRate.name}_'
        '${spec.pixelFormat.name}'
        '.${spec.codec.extension}';
  }

  @override
  Command getCommand(VideoSpec spec, String outputPath, String filename) {
    final String encoder = EncoderMapper.select(spec.codec, backend);
    final String? filter = EncoderMapper.getFilter(encoder, backend);

    final Command cmd = Command();

    // Global args
    cmd.add(backend.hwDeviceArgs);
    cmd.add(<String>['-y']);

    // Input args
    cmd.add(<String>[
      '-f',
      'lavfi',
      '-i',
      _getVideoFilter(spec.size, spec.frameRate, filename),
      '-f',
      'lavfi',
      '-i',
      'sine=frequency=$sineFrequency',
    ]);

    // Codec and filter args
    if (filter != null) {
      cmd.add(<String>['-vf', filter]);
    }

    if (EncoderMapper.needsStrict(encoder)) {
      cmd.add(<String>['-strict', '-2']);
    }

    cmd.add(<String>['-c:v', encoder]);
    cmd.add(<String>['-c:a', spec.codec.audio]);

    // CPU-only pixel format
    if (EncoderMapper.isCpuEncoder(encoder)) {
      cmd.add(<String>['-pix_fmt', spec.pixelFormat.name]);
    }

    // Apply codec tuning
    cmd.add(spec.codec.tuning);

    // Add encoder-specific flags
    cmd.add(backend.encoderFlags(encoder));

    // Final args
    cmd.add(<String>['-shortest']);
    cmd.add(<String>[outputPath]);

    return cmd;
  }

  @override
  Future<void> generate() async {
    for (final Codec codec in Config.codecs) {
      for (final Size size in codec.sizes(backend)) {
        for (final FrameRate frameRate in codec.framerates) {
          for (final PixelFormat pixelFormat in codec.pixelFormats) {
            await encode(
              VideoSpec(
                codec: codec,
                size: size,
                frameRate: frameRate,
                pixelFormat: pixelFormat,
              ),
            );
          }
        }
      }
    }

    logz.s('Video test set generated in $outputDir');
  }
}
