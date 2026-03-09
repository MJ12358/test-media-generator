part of video;

class VideoGenerator implements Generator {
  static late Backend backend;

  final String _outputDir = Config.outputDir;
  final int _duration = Config.duration;
  final int _sineFrequency = Config.sineFrequency;
  final String _fontPath = Config.fontPath;

  VideoGenerator() {
    Directory(_outputDir).createSync(recursive: true);
    backend = Backend.detect();
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
    return '''
      testsrc=duration=$_duration:size=${size.value}:rate=${frameRate.value}, 
      drawtext=fontfile=$_fontPath: 
      text='$filename': 
      x=(w-text_w)/2: 
      y=(h-text_h)/2: 
      fontsize=h/15: 
      fontcolor=white: 
      box=1: 
      boxcolor=black@0.6: 
      boxborderw=10
    ''';
  }

  bool _needsStrictExperimental(String encoder) {
    return encoder == 'libaom-av1';
  }

  Future<void> _encode({
    required Codec codec,
    required Size size,
    required FrameRate frameRate,
    required PixelFormat pixelFormat,
  }) async {
    final String filename = _getFileName(codec, size, frameRate, pixelFormat);

    final String outputPath = '$_outputDir/$filename';

    if (File(outputPath).existsSync()) {
      log.w('Skipping (exists): $filename');
      return;
    }

    try {
      final String encoder = EncoderMapper.getName(codec, backend);
      final String? filter = codec is MJPEG || codec is MPEG2
          ? null
          : backend.filter;

      final List<String> args = <String>[];

      // Global args
      args.addAll(backend.hwDeviceArgs);
      args.addAll(<String>['-y']);

      // Input args
      args.addAll(<String>[
        '-f',
        'lavfi',
        '-i',
        _getVideoFilter(size, frameRate, filename),
        '-f',
        'lavfi',
        '-i',
        'sine=frequency=$_sineFrequency',
      ]);

      // Codec and filter args
      if (filter != null) {
        args.addAll(<String>['-vf', filter]);
      }

      if (_needsStrictExperimental(encoder)) {
        args.addAll(<String>['-strict', '-2']);
      }

      args.addAll(<String>['-c:v', encoder]);
      args.addAll(<String>['-c:a', codec.audio]);

      // CPU-only pixel format
      if (backend is Cpu) {
        args.addAll(<String>['-pix_fmt', pixelFormat.value]);
      }

      // Apply codec tuning
      args.addAll(codec.tuning);

      // Add encoder-specific flags
      args.addAll(codec.encoderFlags);

      // Final args
      args.add('-shortest');
      args.add(outputPath);

      log.i('Encoding: $filename');

      final ProcessResult result = await Process.run('ffmpeg', args);

      if (result.exitCode != 0) {
        throw EncodingException.fromResult(filename, result);
      }
    } on EncodingException catch (e) {
      log.e(e.message);
    } on UnsupportedException catch (e) {
      log.w(e.message);
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
      for (final Size size in codec.sizes) {
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

    log.s('Video test set generated in $_outputDir');
  }
}
