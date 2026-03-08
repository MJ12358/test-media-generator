import 'dart:io';

import '../core/logger.dart';
import 'codecs/codec.dart';
import 'config.dart';

class ImageGenerator {
  final String _outputDir = Config.outputDir;
  final String _fontPath = Config.fontPath;
  final List<String> _sizes = Config.sizes;

  ImageGenerator() {
    Directory(_outputDir).createSync(recursive: true);
  }

  String _buildFileName(Codec codec, String size, String pixelFormat) {
    return '${codec.name}_'
        '${size}_'
        '$pixelFormat.${codec.extension}';
  }

  String _buildDrawTextFilter(
    String filename,
    String size,
    String pixelFormat,
  ) {
    return '''
      nullsrc=s=$size, 
      geq=r=X/W*255:g=Y/H*255:b=128, 
      format=$pixelFormat, 
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

  Future<void> _encode({required Codec codec, required String size}) async {
    final String filename = _buildFileName(codec, size, codec.pixelFormat);

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
      _buildDrawTextFilter(filename, size, codec.pixelFormat),
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

  Future<void> generate() async {
    for (final Codec codec in Config.codecs) {
      for (final String size in _sizes) {
        await _encode(codec: codec, size: size);
      }
    }

    log.s('Image test set generated in $_outputDir');
  }
}
