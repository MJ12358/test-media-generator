part of images;

/// {@template test_media_generator.ImageGenerator}
/// This class is responsible for generating test image files.
/// {@endtemplate}
class ImageGenerator extends Generator {
  late final String fontPath;

  /// {@macro test_media_generator.ImageGenerator}
  ImageGenerator() : super(outputDir: Config.outputDir) {
    fontPath = Config.fontPath;
  }

  String _getFileName(Codec codec, Size size, PixelFormat pixelFormat) {
    return '${codec.name}_'
        '${size.value}_'
        '${pixelFormat.value}'
        '.${codec.extension}';
  }

  String _getDrawTextFilter(
    String filename,
    Size size,
    PixelFormat pixelFormat,
  ) {
    return '''
      nullsrc=s=${size.value}, 
      geq=r=X/W*255:g=Y/H*255:b=128, 
      format=${pixelFormat.value}, 
      drawtext=fontfile=$fontPath: 
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

  Future<void> _encode({required Codec codec, required Size size}) async {
    final String filename = _getFileName(codec, size, codec.pixelFormat);

    final String outputPath = '$outputDir/$filename';

    if (File(outputPath).existsSync()) {
      log.w('Skipping (exists): $filename');
      return;
    }

    try {
      final List<String> args = <String>[];

      // Global args
      args.addAll(<String>['-y']);

      // Input args
      args.addAll(<String>[
        '-f',
        'lavfi',
        '-i',
        _getDrawTextFilter(filename, size, codec.pixelFormat),
      ]);

      // Codec args
      args.addAll(codec.encoderFlags);

      // Final args
      args.addAll(<String>['-frames:v', '1']);
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
        await _encode(codec: codec, size: size);
      }
    }

    log.s('Image test set generated in $outputDir');
  }
}
