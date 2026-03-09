part of images;

class ImageGenerator implements Generator {
  final String _outputDir = Config.outputDir;
  final String _fontPath = Config.fontPath;

  ImageGenerator() {
    Directory(_outputDir).createSync(recursive: true);
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

  Future<void> _encode({required Codec codec, required Size size}) async {
    final String filename = _getFileName(codec, size, codec.pixelFormat);

    final String outputPath = '$_outputDir/$filename';

    if (File(outputPath).existsSync()) {
      log.w('Skipping (exists): $filename');
      return;
    }

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
    try {
      final ProcessResult result = await Process.run('ffmpeg', args);

      final File file = File(outputPath);

      // Check if the encoding was successful and the output file is valid.
      if (result.exitCode != 0 ||
          !file.existsSync() ||
          file.lengthSync() == 0) {
        log.e('Error encoding $filename: ${result.stderr}');
        // Clean up any invalid output file.
        if (file.existsSync()) {
          file.deleteSync();
        }
      }
    } catch (e) {
      log.e('Exception encoding $filename: $e');
    }
  }

  @override
  Future<void> generate() async {
    for (final Codec codec in Config.codecs) {
      for (final Size size in codec.sizes) {
        await _encode(codec: codec, size: size);
      }
    }

    log.s('Image test set generated in $_outputDir');
  }
}
