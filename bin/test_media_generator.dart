import 'package:dart_logz/dart_logz.dart';

import 'audio/audio.dart';
import 'core/cli.dart';
import 'core/pubspec.dart';
import 'images/images.dart';
import 'video/video.dart';

void main(List<String> arguments) async {
  final CliOptions options = Cli.parse(arguments);
  final Pubspec pub = Pubspec();

  try {
    // Process the parsed arguments.
    if (options.showHelp) {
      Cli.printUsage(pub.name);
      return;
    }

    // Print version information if the --version flag is provided.
    if (options.showVersion) {
      logz.i('${pub.name} version: ${pub.version}');
      return;
    }

    // Generate audio
    if (options.generateAudio) {
      await AudioGenerator().generate();
    }

    // Generate images
    if (options.generateImages) {
      await ImageGenerator().generate();
    }

    // Generate videos
    if (options.generateVideos) {
      await VideoGenerator().generate();
    }

    // If no generation type was specified, print an error message.
    if (!options.generateAudio &&
        !options.generateImages &&
        !options.generateVideos) {
      logz.e('No generation type specified. Use --help for usage information.');
    }
  } on FormatException catch (e) {
    // Print usage information if an invalid argument was provided.
    logz.e(e.message);
    logz.i('');
    Cli.printUsage(pub.name);
  }
}
