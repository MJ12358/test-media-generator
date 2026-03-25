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
        '${pixelFormat.name}'
        '.${codec.extension}';
  }

  String _getSource(Size size, PixelFormat pixelFormat) {
    return <String>[
      'nullsrc=s=${size.value}',
      'geq=r=X/W*255:g=Y/H*255:b=128',
      'format=${pixelFormat.name}',
    ].join(',');
  }

  String _getDrawTextFilter(
    String filename,
    Size size,
    PixelFormat pixelFormat,
  ) {
    final String src = _getSource(size, pixelFormat);

    final String text = DrawTextBuilder.build(
      fontPath: fontPath,
      text: filename,
      height: size.height,
      width: size.width,
    );

    return '$src,drawtext=$text';
  }

  Future<void> _encode({
    required Codec codec,
    required Size size,
    required PixelFormat pixelFormat,
  }) async {
    final String filename = _getFileName(codec, size, pixelFormat);

    final String outputPath = '$outputDir/$filename';

    if (File(outputPath).existsSync()) {
      logz.w('Skipping (exists): $filename');
      return;
    }

    try {
      final Command cmd = Command();

      // Global args
      cmd.add(<String>['-y']);

      // Input args
      cmd.add(<String>[
        '-f',
        'lavfi',
        '-i',
        _getDrawTextFilter(filename, size, pixelFormat),
      ]);

      // Codec args
      cmd.add(codec.encoderFlags);

      // Final args
      cmd.add(<String>['-frames:v', '1']);
      cmd.add(<String>[outputPath]);

      logz.i('Encoding: $filename');

      await cmd.run(filename);
    } on EncodingException catch (e) {
      logz.e(e.message);
    } catch (e) {
      logz.e('Exception encoding $filename: $e');
    } finally {
      final File file = File(outputPath);
      if (file.existsSync() && file.lengthSync() == 0) {
        logz.w('Cleaning up invalid output file: $filename');
        file.deleteSync();
      }
    }
  }

  @override
  Future<void> generate() async {
    for (final Codec codec in Config.codecs) {
      for (final Size size in codec.sizes) {
        for (final PixelFormat pixelFormat in codec.pixelFormats) {
          await _encode(codec: codec, size: size, pixelFormat: pixelFormat);
        }
      }
    }

    logz.s('Image test set generated in $outputDir');
  }
}
