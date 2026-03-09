part of video;

class EncoderMapper {
  static String getName(Codec codec, Backend backend) {
    if (codec is MJPEG) {
      return 'mjpeg';
    }
    if (codec is MPEG2) {
      return 'mpeg2video';
    }

    final String key = '${codec.name}:${backend.name}';
    switch (key) {
      // Nvidia
      case 'h264:nvidia':
        return 'h264_nvenc';
      case 'h265:nvidia':
        return 'hevc_nvenc';
      case 'av1:nvidia':
        return 'av1_nvenc';

      // Intel
      case 'h264:intel-qsv':
        return 'h264_qsv';
      case 'h265:intel-qsv':
        return 'hevc_qsv';
      case 'av1:intel-qsv':
        return 'av1_qsv';

      // VAAPI
      case 'h264:vaapi':
        return 'h264_vaapi';
      case 'h265:vaapi':
        return 'hevc_vaapi';
      case 'av1:vaapi':
        return 'av1_vaapi';
      case 'vp9:vaapi':
        return 'vp9_vaapi';

      // CPU
      case 'h264:cpu':
        return 'libx264';
      case 'h265:cpu':
        return 'libx265';
      case 'vp9:cpu':
        return 'libvpx-vp9';
      case 'av1:cpu':
        return 'libaom-av1';

      default:
        throw UnsupportedException.codecBackend(key);
    }
  }
}
