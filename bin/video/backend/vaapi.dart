part of video;

/// {@template test_media_generator.Vaapi}
/// This defines the VAAPI backend, which uses hardware acceleration for video
/// encoding and decoding on Linux systems with compatible GPUs.
///
/// https://en.wikipedia.org/wiki/Video_Acceleration_API
/// {@endtemplate}
class Vaapi extends Backend {
  /// {@macro test_media_generator.Vaapi}
  Vaapi();

  @override
  String get name => 'vaapi';

  @override
  String get filter => 'format=nv12,hwupload';

  @override
  List<String> get hwDeviceArgs => <String>[
    '-init_hw_device',
    'vaapi=vaapi:/dev/dri/renderD128',
    '-filter_hw_device',
    'vaapi',
  ];

  @override
  bool get isAvailable {
    try {
      if (!_encoders.contains('h264_vaapi')) {
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
    if (File('/dev/dri/renderD128').existsSync()) {
      return true;
    } else {
      return false;
    }
  }

  bool _isAvailableOnWindows() {
    // VAAPI is not available on Windows
    return false;
  }
}
