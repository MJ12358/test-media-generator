import 'dart:io';

import 'encoding_exception.dart';
import 'logger.dart';

/// A class to build and run ffmpeg commands.
class Command {
  /// The ffmpeg executable.
  static const String _exe = 'ffmpeg';

  /// A list of arguments to pass to ffmpeg.
  final List<String> _args = <String>[];

  /// Adds a list of arguments to the command.
  void add(List<String> values) {
    _args.addAll(values);
  }

  /// Runs the command.
  ///
  /// Throws an [EncodingException] if the command fails.
  Future<void> run(String filename) async {
    log.d(toString());

    final ProcessResult result = await Process.run(_exe, _args);

    if (result.exitCode != 0) {
      throw EncodingException.fromResult(filename, result);
    }
  }

  @override
  String toString() {
    return <String>[_exe, ..._args.map(_quote)].join(' ');
  }

  String _quote(String v) {
    return v.contains(' ') ? '"$v"' : v;
  }
}
