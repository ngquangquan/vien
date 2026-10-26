import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

enum TtsAccent {
  us('en-US', 'US'),
  uk('en-GB', 'UK');

  final String locale;
  final String label;
  const TtsAccent(this.locale, this.label);
}

class TtsService {
  static final TtsService _instance = TtsService._internal();
  factory TtsService() => _instance;
  TtsService._internal();

  final FlutterTts _flutterTts = FlutterTts();
  bool _isInitialized = false;
  double _speechRate = 0.5; // Tốc độ chuẩn dễ nghe
  double _pitch = 1.0;
  final double _volume = 1.0;

  double get speechRate => _speechRate;
  double get pitch => _pitch;
  double get volume => _volume;

  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      if (!kIsWeb) {
        if (Platform.isIOS) {
          await _flutterTts.setSharedInstance(true);
          await _flutterTts.setIosAudioCategory(
            IosTextToSpeechAudioCategory.ambientSolo,
            [
              IosTextToSpeechAudioCategoryOptions.allowBluetooth,
              IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
              IosTextToSpeechAudioCategoryOptions.mixWithOthers,
            ],
          );
        }
      }

      await _flutterTts.setVolume(_volume);
      await _flutterTts.setPitch(_pitch);
      await _flutterTts.setSpeechRate(_speechRate);

      _flutterTts.setErrorHandler((msg) {
        debugPrint('TTS error: $msg');
      });

      _isInitialized = true;
    } catch (e) {
      debugPrint('Error initializing TTS: $e');
    }
  }

  Future<void> setSpeechRate(double rate) async {
    _speechRate = rate.clamp(0.1, 1.0);
    await _flutterTts.setSpeechRate(_speechRate);
  }

  Future<void> setPitch(double pitch) async {
    _pitch = pitch.clamp(0.5, 2.0);
    await _flutterTts.setPitch(_pitch);
  }

  Future<void> speak(
    String text, {
    TtsAccent accent = TtsAccent.us,
    double? customRate,
  }) async {
    final cleanText = text.trim();
    if (cleanText.isEmpty) return;

    if (!_isInitialized) {
      await initialize();
    }

    try {
      await _flutterTts.stop();
      await _flutterTts.setLanguage(accent.locale);

      if (customRate != null) {
        await _flutterTts.setSpeechRate(customRate.clamp(0.1, 1.0));
      } else {
        await _flutterTts.setSpeechRate(_speechRate);
      }

      await _flutterTts.speak(cleanText);
    } catch (e) {
      debugPrint('TTS speak error: $e');
    }
  }

  Future<void> stop() async {
    try {
      await _flutterTts.stop();
    } catch (e) {
      debugPrint('TTS stop error: $e');
    }
  }
}
