/// A helper class to build the drawtext filter.
/// This is used to generate the filter string for the drawtext filter,
/// which is used to overlay text on the generated images and videos.
class DrawTextBuilder {
  /// Builds the drawtext filter string.
  /// The [fontPath] is the path to the font file to be used.
  /// The [text] is the text to be displayed on the image or video.
  /// The [height] and [width] are the dimensions of the image or video,
  /// which are used to compute the font size and position.
  static String build({
    required String fontPath,
    required String text,
    required int height,
    required int width,
  }) {
    final String escaped = _escape(text);

    final int fontSize = _computeFontSize(
      text: text,
      height: height,
      width: width,
    );

    return <String>[
      'fontfile=$fontPath',
      "text='$escaped'",

      'x=(w-text_w)/2',
      'y=(h-text_h)/2',

      'fontsize=$fontSize',
      'line_spacing=8',

      'fontcolor=white',

      'box=1',
      'boxcolor=black@0.6',
      'boxborderw=10',

      'text_align=center', // center multi-line text
      'fix_bounds=true', // prevents overflow clipping
    ].join(':');
  }

  /// Computes the font size based on the image dimensions and text length.
  static int _computeFontSize({
    required String text,
    required int height,
    required int width,
  }) {
    final int charCount = text.length;

    // --- Tunables ---
    const double glyphFactor = 0.55; // avg glyph width ratio
    const double padding = 0.9; // use 90% of width
    const double minScale = 0.04; // min relative to min dimension
    const double maxScale = 0.12; // max relative to min dimension

    final double maxWidth = width * padding;

    final double rawFontSize = maxWidth / (charCount * glyphFactor);

    // Clamp relative to image size (prevents absurd values)
    final double minFont = (width < height ? width : height) * minScale;
    final double maxFont = (width < height ? width : height) * maxScale;

    final double clamped = rawFontSize.clamp(minFont, maxFont);

    return clamped.floor();
  }

  /// Escapes special characters in the text for use in the drawtext filter.
  static String _escape(String text) {
    return text
        .replaceAll(':', r'\:')
        .replaceAll("'", r"\'")
        .replaceAll(',', r'\,');
  }
}
