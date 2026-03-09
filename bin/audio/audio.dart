library audio;

import 'dart:io';

import 'package:path/path.dart' as p;

import '../core/encoding_exception.dart';
import '../core/generator.dart';
import '../core/logger.dart';
import '../core/unsupported_exception.dart';

part 'audio_generator.dart';
part 'codecs/aac.dart';
part 'codecs/ac3.dart';
part 'codecs/alac.dart';
part 'codecs/codec.dart';
part 'codecs/flac.dart';
part 'codecs/mp3.dart';
part 'codecs/opus.dart';
part 'codecs/vorbis.dart';
part 'codecs/wav.dart';
part 'config.dart';
part 'core/bit_depth.dart';
part 'core/bit_rate.dart';
part 'core/channels.dart';
part 'core/sample_rate.dart';
