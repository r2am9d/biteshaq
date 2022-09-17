import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

YoutubePlayerController useYoutubePlayerController({required String videoId}) =>
    use(_YoutubePlayerControllerHook(videoId: videoId));

class _YoutubePlayerControllerHook extends Hook<YoutubePlayerController> {
  const _YoutubePlayerControllerHook({required this.videoId});

  final String videoId;

  @override
  _YoutubePlayerControllerHookState createState() =>
      _YoutubePlayerControllerHookState();
}

class _YoutubePlayerControllerHookState
    extends HookState<YoutubePlayerController, _YoutubePlayerControllerHook> {
  // Set default values
  late YoutubePlayerController _youtubePlayerCtrl;

  @override
  void initHook() {
    _youtubePlayerCtrl = YoutubePlayerController(
      initialVideoId: hook.videoId,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    );
  }

  @override
  YoutubePlayerController build(BuildContext context) => _youtubePlayerCtrl;

  @override
  void deactivate() {
    _youtubePlayerCtrl.pause();
  }

  @override
  void dispose() {
    _youtubePlayerCtrl.dispose();
  }
}
