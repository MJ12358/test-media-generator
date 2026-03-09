part of video;

/// This file defines the abstract base class [Codec]
/// which serves as a blueprint for specific video codec implementations.
abstract class Codec {
  /// The name of the codec.
  String get name;

  /// The file extension associated with this codec.
  String get extension;

  /// The audio codec to be used with this video codec.
  /// This can be used to specify the audio encoding format
  /// that pairs well with the video codec.
  String get audio;

  /// A list of additional encoder flags specific to this codec.
  List<String> get encoderFlags => <String>[];

  /// A list of framerates to generate.
  List<FrameRate> get framerates => <FrameRate>[
    FrameRate.fr24,
    FrameRate.fr30,
    FrameRate.fr60,
  ];

  /// A list of pixel formats supported by this codec.
  List<PixelFormat> get pixelFormats => <PixelFormat>[
    PixelFormat.yuv420p,
    PixelFormat.yuv422p,
    PixelFormat.yuv444p,
  ];

  /// The sizes(resolutions) to generate.
  List<Size> get sizes => <Size>[
    Size.s140,
    Size.s360,
    Size.s720,
    Size.s1080,
    Size.s1440,
    Size.s2160,
    Size.s4320,
  ];

  /// A list of tuning parameters for the codec.
  /// This can be used to specify codec-specific settings.
  List<String> get tuning => <String>[];
}
