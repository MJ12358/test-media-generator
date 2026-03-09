part of video;

/// {@template test_media_generator.Intel}
/// This defines the Intel Quick Sync Video (QSV) backend, which uses
/// hardware acceleration for video encoding and decoding on Intel GPUs.
///
/// https://en.wikipedia.org/wiki/Intel_Quick_Sync_Video
/// {@endtemplate}
class Intel extends Backend {
  /// {@macro test_media_generator.Intel}
  Intel();

  @override
  String get name => 'intel-qsv';

  @override
  String get filter => 'format=nv12,hwupload=extra_hw_frames=64';

  @override
  List<String> get hwDeviceArgs {
    if (Platform.isLinux) {
      return <String>[
        '-init_hw_device',
        'qsv=qsv:/dev/dri/renderD128',
        '-filter_hw_device',
        'qsv',
      ];
    }
    if (Platform.isWindows) {
      return <String>['-init_hw_device', 'qsv=qsv', '-filter_hw_device', 'qsv'];
    }
    return <String>[];
  }

  @override
  bool get isAvailable {
    try {
      final ProcessResult result = Process.runSync('ffmpeg', <String>[
        '-encoders',
      ]);
      if (!result.stdout.toString().contains('h264_qsv')) {
        return false;
      }
      if (Platform.isLinux) {
        return _isAvailableOnLinux();
      }
      if (Platform.isWindows) {
        return _isAvailableOnWindows();
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  bool _isAvailableOnLinux() {
    if (!File('/dev/dri/renderD128').existsSync()) {
      return false;
    }
    final ProcessResult lspciResult = Process.runSync('lspci', <String>[]);
    return lspciResult.stdout.toString().toLowerCase().contains(
      'intel.*graphics',
    );
  }

  bool _isAvailableOnWindows() {
    final ProcessResult result = Process.runSync('where', <String>[
      'qsv-decoder',
    ]);
    return result.exitCode == 0;
  }
}
