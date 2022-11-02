import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:system_settings/system_settings.dart';

import 'package:biteshaq/src/variables/app_variables.dart';

FlutterTts useFlutterTts({required ValueNotifier<TtsState> ttsState}) =>
    use(_FlutterTtsHook(ttsState: ttsState));

class _FlutterTtsHook extends Hook<FlutterTts> {
  const _FlutterTtsHook({required this.ttsState});

  final ValueNotifier<TtsState> ttsState;

  @override
  _FlutterTtsHookState createState() => _FlutterTtsHookState();
}

class _FlutterTtsHookState extends HookState<FlutterTts, _FlutterTtsHook> {
  // Set default values
  final double _pitch = 1.25;
  final double _volume = 1.0;
  final double _speechRate = .45;
  final FlutterTts _flutterTts = FlutterTts();

  void _stateHandler(TtsState state) {
    hook.ttsState.value = state;
  }

  // * Temp disabled. Handler doesn't get called upon start
  // void _onStart() => _stateHandler(TtsState.playing);

  // * Temp disabled due to navigation issues
  // void _onCancel() => _stateHandler(TtsState.stopped);

  void _onComplete() => _stateHandler(TtsState.stopped);

  void _onPause() => _stateHandler(TtsState.paused);
  void _onContinue() => _stateHandler(TtsState.playing);
  void _onError(dynamic message) {
    _stateHandler(TtsState.stopped);
    if (kDebugMode) print('TTS_HOOK_ERROR: $message');
  }

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

    // await flutterTts.awaitSpeakCompletion(true);
    await _flutterTts.setIosAudioCategory(
      IosTextToSpeechAudioCategory.playback,
      [
        IosTextToSpeechAudioCategoryOptions.allowBluetooth,
        IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
        IosTextToSpeechAudioCategoryOptions.mixWithOthers
      ],
      IosTextToSpeechAudioMode.voicePrompt,
    );

    // Set handlers
    // _flutterTts.setStartHandler(_onStart);
    // _flutterTts.setCancelHandler(_onCancel);
    _flutterTts.setCompletionHandler(_onComplete);

    _flutterTts.setPauseHandler(_onPause);
    _flutterTts.setContinueHandler(_onContinue);
    _flutterTts.setErrorHandler(_onError);
  }

  void _stopTts() async => await _flutterTts.stop();

  @override
  void initHook() {
    super.initHook();
    _checkTts();
    _initTts();
  }

  @override
  FlutterTts build(BuildContext context) => _flutterTts;

  @override
  void dispose() {
    _stopTts();
    super.dispose();
  }
}
