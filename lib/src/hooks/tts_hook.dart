import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:system_settings/system_settings.dart';

FlutterTts useFlutterTts() => use(const _FlutterTtsHook());

class _FlutterTtsHook extends Hook<FlutterTts> {
  const _FlutterTtsHook();

  @override
  _FlutterTtsHookState createState() => _FlutterTtsHookState();
}

class _FlutterTtsHookState extends HookState<FlutterTts, _FlutterTtsHook> {
  // Set default values
  final double _pitch = 1.25;
  final double _volume = 1.0;
  final double _speechRate = .50;
  final FlutterTts _flutterTts = FlutterTts();

  void _checkTts() async {
    final voices = await _flutterTts.getVoices as List;
    final languages = await _flutterTts.getLanguages as List;

    if (voices.isEmpty || languages.isEmpty) {
      SystemSettings.accessibility();
    }
  }

  void _initTts() async {
    await _flutterTts.setPitch(_pitch);
    await _flutterTts.setVolume(_volume);
    await _flutterTts.setSpeechRate(_speechRate);

    // await _flutterTts.awaitSpeakCompletion(true);
    await _flutterTts.setIosAudioCategory(
      IosTextToSpeechAudioCategory.playback,
      [
        IosTextToSpeechAudioCategoryOptions.allowBluetooth,
        IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
        IosTextToSpeechAudioCategoryOptions.mixWithOthers
      ],
      IosTextToSpeechAudioMode.voicePrompt,
    );
  }

  void _stopTts() async => await _flutterTts.stop();

  @override
  void initHook() {
    _checkTts();
    _initTts();
  }

  @override
  FlutterTts build(BuildContext context) => _flutterTts;

  @override
  void dispose() {
    _stopTts();
  }
}
