part of images;

class ImageSpec {
  final Codec codec;
  final Size size;
  final PixelFormat pixelFormat;

  ImageSpec({
    required this.codec,
    required this.size,
    required this.pixelFormat,
  });
}

/// {@template test_media_generator.ImageGenerator}
/// This class is responsible for generating test image files.
/// {@endtemplate}
class ImageGenerator extends Generator<ImageSpec> {
  late final String fontPath;

  /// {@macro test_media_generator.ImageGenerator}
  ImageGenerator() : super(outputDir: Config.outputDir) {
    fontPath = Config.fontPath;
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

  @override
  String getFileName(ImageSpec spec) {
    return '${spec.codec.name}_'
        '${spec.size.value}_'
        '${spec.pixelFormat.name}'
        '.${spec.codec.extension}';
  }

  @override
  Command getCommand(ImageSpec spec, String outputPath, String filename) {
    final Command cmd = Command();

    // Global args
    cmd.add(<String>['-y']);

    // Input args
    cmd.add(<String>[
      '-f',
      'lavfi',
      '-i',
      _getDrawTextFilter(filename, spec.size, spec.pixelFormat),
    ]);

    // Codec args
    cmd.add(spec.codec.encoderFlags);

    // Final args
    cmd.add(<String>['-frames:v', '1']);
    cmd.add(<String>[outputPath]);

    return cmd;
  }

  @override
  Future<void> generate() async {
    for (final Codec codec in Config.codecs) {
      for (final Size size in codec.sizes) {
        for (final PixelFormat pixelFormat in codec.pixelFormats) {
          await encode(
            ImageSpec(codec: codec, size: size, pixelFormat: pixelFormat),
          );
        }
      }
    }

    logz.s('Image test set generated in $outputDir');
  }
}
