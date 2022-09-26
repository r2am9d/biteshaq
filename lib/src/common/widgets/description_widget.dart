// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:biteshaq/src/hooks/tts_hook.dart';
import 'package:biteshaq/src/utils/app_utils.dart';
import 'package:biteshaq/src/themes/app_color.dart';
import 'package:biteshaq/src/constants/app_constants.dart';

class DescriptionWidget extends HookWidget {
  const DescriptionWidget({
    super.key,
    required this.description,
    this.withHeaderButton = false,
  });

  final String description;
  final bool withHeaderButton;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final descTtsState = useState(TtsState.initial);
    final descAnimationCtrl = useAnimationController(
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
    );
    useAnimation(descAnimationCtrl);

    final descTts = useFlutterTts(
      ttsState: descTtsState,
      animationCtrl: descAnimationCtrl,
    );

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /// Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Description',
                style: theme.textTheme.headline5?.copyWith(
                  color: AppColor().primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (withHeaderButton) ...[
                ElevatedButton(
                  onPressed: descTtsState.value.name == 'playing'
                      ? () => AppUtils().ttsStop([descTts, descAnimationCtrl])
                      : () => AppUtils()
                          .ttsSpeak([description, descTts, descAnimationCtrl]),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(24),
                    backgroundColor: AppColor().secondary,
                  ),
                  child: AnimatedIcon(
                    icon: AnimatedIcons.play_pause,
                    progress: descAnimationCtrl,
                  ),
                ),
              ],
            ],
          ),

          const SizedBox(height: 8),

          /// Content
          Text(
            description,
            style: theme.textTheme.bodyText1?.copyWith(
              color: AppColor().black,
            ),
          ),
        ],
      ),
    );
  }
}
