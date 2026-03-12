part of video;

/// {@template test_media_generator.VideoGenerator}
/// This class is responsible for generating test video files.
/// {@endtemplate}
class VideoGenerator extends Generator {
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

  String _getFileName(
    Codec codec,
    Size size,
    FrameRate frameRate,
    PixelFormat pixelFormat,
  ) {
    return '${codec.name}_'
        '${size.name}_'
        '${frameRate.name}_'
        '${pixelFormat.name}'
        '.${codec.extension}';
  }

  String _getVideoFilter(Size size, FrameRate frameRate, String filename) {
    final String src = <String>[
      'testsrc=duration=$duration',
      'size=${size.value}',
      'rate=${frameRate.value}',
    ].join(':');

    final String text = <String>[
      'fontfile=$fontPath',
      "text='$filename'",
      'x=(w-text_w)/2',
      'y=(h-text_h)/2',
      'fontsize=h/15',
      'fontcolor=white',
      'box=1',
      'boxcolor=black@0.6',
      'boxborderw=10',
    ].join(':');

    return '$src,drawtext=$text';
  }

  Future<void> _encode({
    required Codec codec,
    required Size size,
    required FrameRate frameRate,
    required PixelFormat pixelFormat,
  }) async {
    final String filename = _getFileName(codec, size, frameRate, pixelFormat);

    final String outputPath = '$outputDir/$filename';

    if (File(outputPath).existsSync()) {
      log.w('Skipping (exists): $filename');
      return;
    }

    try {
      final String encoder = EncoderMapper.select(codec, backend);
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
        _getVideoFilter(size, frameRate, filename),
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
      cmd.add(<String>['-c:a', codec.audio]);

      // CPU-only pixel format
      if (EncoderMapper.isCpuEncoder(encoder)) {
        cmd.add(<String>['-pix_fmt', pixelFormat.value]);
      }

      // Apply codec tuning
      cmd.add(codec.tuning);

      // Add encoder-specific flags
      cmd.add(backend.encoderFlags(encoder));

      // Final args
      cmd.add(<String>['-shortest']);
      cmd.add(<String>[outputPath]);

      log.i('Encoding: $filename');

      await cmd.run(filename);
    } on EncodingException catch (e) {
      log.e(e.message);
    } catch (e) {
      log.e('Exception encoding $filename: $e');
    } finally {
      final File file = File(outputPath);
      if (file.existsSync() && file.lengthSync() == 0) {
        log.w('Cleaning up invalid output file: $filename');
        file.deleteSync();
      }
    }
  }

  @override
  Future<void> generate() async {
    for (final Codec codec in Config.codecs) {
      for (final Size size in codec.sizes(backend)) {
        for (final FrameRate frameRate in codec.framerates) {
          for (final PixelFormat pixelFormat in codec.pixelFormats) {
            await _encode(
              codec: codec,
              size: size,
              frameRate: frameRate,
              pixelFormat: pixelFormat,
            );
          }
        }
      }
    }

    log.s('Video test set generated in $outputDir');
  }
}
