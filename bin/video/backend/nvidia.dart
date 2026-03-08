import 'dart:io';

import 'backend.dart';

class Nvidia extends Backend {
  @override
  String get name => 'nvidia';

  @override
  String get filter => 'format=yuv420p,hwupload_cuda';

  @override
  List<String> get hwDeviceArgs => <String>[
    '-init_hw_device',
    'cuda=cuda',
    '-filter_hw_device',
    'cuda',
  ];

  @override
  bool get isAvailable {
    try {
      final ProcessResult result = Process.runSync('ffmpeg', <String>[
        '-encoders',
      ]);
      final bool hasNvenc = result.stdout.toString().contains('h264_nvenc');
      if (Platform.isLinux) {
        return hasNvenc && _isAvailableOnLinux();
      }
      if (Platform.isWindows) {
        return hasNvenc && _isAvailableOnWindows();
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  bool _isAvailableOnLinux() {
    final ProcessResult result = Process.runSync('which', <String>[
      'nvidia-smi',
    ]);
    return result.exitCode == 0;
  }

  bool _isAvailableOnWindows() {
    final ProcessResult result = Process.runSync('where', <String>[
      'nvidia-smi',
    ]);
    return result.exitCode == 0;
  }
}
