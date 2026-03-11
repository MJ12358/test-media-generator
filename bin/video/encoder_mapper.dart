part of video;

/// This class maps a codec and backend to the
/// appropriate encoder name and filter to use with FFmpeg.
/// It also provides a method to check if an encoder is a CPU encoder,
/// which can be useful for determining if hardware acceleration is being used.
class EncoderMapper {
  /// Gets the encoder name for the given codec and backend.
  static String select(Codec codec, Backend backend) {
    final String? encoder = codec.hardwareEncoders[backend.runtimeType];

    if (encoder != null) {
      return encoder;
    }

    log.w(
      'No ${codec.name} encoder for ${backend.name}, '
      'falling back to CPU.',
    );

    return codec.softwareEncoder;
  }

  /// Gets the filter for the given codec and backend.
  static String? getFilter(String encoder, Backend backend) {
    if (isCpuEncoder(encoder)) {
      return null;
    } else {
      return backend.filter;
    }
  }

  /// Checks if the given encoder is a CPU encoder.
  static bool isCpuEncoder(String encoder) {
    return _cpuEncoders.contains(encoder);
  }

  /// Checks if the given encoder requires the -strict -2 flag.
  static bool needsStrict(String encoder) {
    return encoder == 'libaom-av1';
  }

  /// A set of known CPU encoders.
  /// This is used to determine if an encoder is a CPU encoder or not.
  static const Set<String> _cpuEncoders = <String>{
    'libx264',
    'libx265',
    'libvpx-vp9',
    'libaom-av1',
    'mpeg2video',
    'mjpeg',
  };
}
