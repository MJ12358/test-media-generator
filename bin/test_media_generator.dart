import 'package:args/args.dart';

import 'audio/audio.dart';
import 'core/generator.dart';
import 'core/logger.dart';
import 'images/images.dart';
import 'video/video.dart';

const String version = '0.0.1';

ArgParser _buildParser() {
  return ArgParser()
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'Print this usage information.',
    )
    ..addFlag(
      'version',
      abbr: 'v',
      negatable: false,
      help: 'Print the tool version.',
    )
    ..addCommand(
      'generate',
      ArgParser()
        ..addFlag('audio', abbr: 'a', help: 'Generate audio files')
        ..addFlag('images', abbr: 'i', help: 'Generate image files')
        ..addFlag('videos', abbr: 'v', help: 'Generate video files'),
    );
}

void _printUsage(ArgParser argParser) {
  log.i('Usage: dart test_media_generator.dart <flags> [arguments]');
  log.i(argParser.usage);
}

void main(List<String> arguments) async {
  final ArgParser argParser = _buildParser();
  bool generateAudio = false;
  bool generateImages = false;
  bool generateVideos = false;

  try {
    final ArgResults results = argParser.parse(arguments);

    // Process the parsed arguments.
    if (results.flag('help')) {
      _printUsage(argParser);
      return;
    }

    // Print version information if the --version flag is provided.
    if (results.flag('version')) {
      log.i('test_media_generator version: $version');
      return;
    }

    // Check if the 'generate' command was used and set the appropriate flags.
    if (results.command?.name == 'generate') {
      generateAudio = results.command!.flag('audio');
      generateImages = results.command!.flag('images');
      generateVideos = results.command!.flag('videos');
    }

    // Generate audio
    if (generateAudio) {
      final Generator generator = AudioGenerator();
      await generator.generate();
    }

    // Generate images
    if (generateImages) {
      final Generator generator = ImageGenerator();
      await generator.generate();
    }

    // Generate videos
    if (generateVideos) {
      final Generator generator = VideoGenerator();
      await generator.generate();
    }

    // If no generation type was specified, print an error message.
    if (!generateAudio && !generateImages && !generateVideos) {
      log.e('No generation type specified. Use --help for usage information.');
    }
  } on FormatException catch (e) {
    // Print usage information if an invalid argument was provided.
    log.e(e.message);
    log.i('');
    _printUsage(argParser);
  }
}
