import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:system_settings/system_settings.dart';

import 'package:biteshaq/src/constants/app_constants.dart';

FlutterTts useFlutterTts({
  required ValueNotifier<TtsState> ttsState,
  required AnimationController animationCtrl,
}) =>
    use(_FlutterTtsHook(ttsState: ttsState, animationCtrl: animationCtrl));

class _FlutterTtsHook extends Hook<FlutterTts> {
  const _FlutterTtsHook({
    required this.ttsState,
    required this.animationCtrl,
  });

  final ValueNotifier<TtsState> ttsState;
  final AnimationController animationCtrl;

  @override
  _FlutterTtsHookState createState() => _FlutterTtsHookState();
}

class _FlutterTtsHookState extends HookState<FlutterTts, _FlutterTtsHook> {
  // Set default values
  final double _pitch = 1.25;
  final double _volume = 1.0;
  final double _speechRate = .50;
  final FlutterTts _flutterTts = FlutterTts();

  void _onStart() {
    hook.ttsState.value = TtsState.playing;
    print('TTS_HOOK_PRINT: ${hook.animationCtrl.status}');
  }

  void _onCancel() {
    hook.ttsState.value = TtsState.stopped;
  }

  void _onComplete() async {
    hook.ttsState.value = TtsState.stopped;
    await hook.animationCtrl.reverse();
    print('TTS_HOOK_PRINT: ${hook.animationCtrl.status}');
  }

  // void _onPause() async {
  //   hook.ttsState.value = TtsState.stopped;
  //   await hook.animationCtrl.reverse();
  // }

  // void _onContinue() async {
  //   hook.ttsState.value = TtsState.playing;
  //   await hook.animationCtrl.forward();
  // }

  // void _onError(dynamic message) async {
  //   hook.ttsState.value = TtsState.stopped;
  //   await hook.animationCtrl.reverse();
  //   print('TTS_HOOK_ERROR:  $message');
  // }

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
    _flutterTts.setStartHandler(_onStart);
    _flutterTts.setCancelHandler(_onCancel);
    _flutterTts.setCompletionHandler(_onComplete);

    // flutterTts.setPauseHandler(_onPause);
    // flutterTts.setContinueHandler(_onContinue);
    // flutterTts.setErrorHandler(_onError);
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
