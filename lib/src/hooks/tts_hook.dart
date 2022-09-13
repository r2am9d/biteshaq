import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:biteshaq/src/constants/app_constants.dart';

FlutterTts useFlutterTts() => use(const _FlutterTtsHook());

class _FlutterTtsHook extends Hook<FlutterTts> {
  const _FlutterTtsHook();

  @override
  _FlutterTtsHookState createState() => _FlutterTtsHookState();
}

class _FlutterTtsHookState extends HookState<FlutterTts, _FlutterTtsHook> {
  // Set default values
  final FlutterTts _flutterTts = FlutterTts();
  TtsState _ttsState = TtsState.stopped;

  void _setStateHandler(TtsState state) {
    setState(() {
      _ttsState = state;
    });
  }

  void _startHandler() => _setStateHandler(TtsState.playing);
  void _completionHandler() => _setStateHandler(TtsState.stopped);
  void _cancelHandler() => _setStateHandler(TtsState.stopped);
  void _errorHandler(dynamic message) => _setStateHandler(TtsState.stopped);

  void _initTts() async {
    await _flutterTts.awaitSpeakCompletion(true);
    await _flutterTts.setIosAudioCategory(
      IosTextToSpeechAudioCategory.playback,
      [
        IosTextToSpeechAudioCategoryOptions.allowBluetooth,
        IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
        IosTextToSpeechAudioCategoryOptions.mixWithOthers
      ],
      IosTextToSpeechAudioMode.voicePrompt,
    );

    _flutterTts.setStartHandler(_startHandler);
    _flutterTts.setCompletionHandler(_completionHandler);
    _flutterTts.setCancelHandler(_cancelHandler);
    _flutterTts.setErrorHandler(_errorHandler);
  }

  @override
  void initHook() {
    _initTts();
  }

  @override
  FlutterTts build(BuildContext context) => _flutterTts;

  @override
  void dispose() {
    _flutterTts.stop();
  }
}
