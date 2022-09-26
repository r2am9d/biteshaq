// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:biteshaq/src/hooks/tts_hook.dart';
import 'package:biteshaq/src/utils/app_utils.dart';
import 'package:biteshaq/src/themes/app_color.dart';
import 'package:biteshaq/src/constants/app_constants.dart';

class ProcedureWidget extends HookWidget {
  const ProcedureWidget({
    super.key,
    required this.procedure,
    this.withHeaderButton = false,
  });

  final List<String> procedure;
  final bool withHeaderButton;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final procTtsState = useState(TtsState.initial);
    final procAnimationCtrl = useAnimationController(
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
    );
    useAnimation(procAnimationCtrl);
    final mProcedure = AppUtils().combineString(procedure);

    final procTts = useFlutterTts(
      ttsState: procTtsState,
      animationCtrl: procAnimationCtrl,
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
                'Procedure',
                style: theme.textTheme.headline5?.copyWith(
                  color: AppColor().primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (withHeaderButton) ...[
                ElevatedButton(
                  onPressed: procTtsState.value.name == 'playing'
                      ? () => AppUtils().ttsStop([procTts, procAnimationCtrl])
                      : () => AppUtils()
                          .ttsSpeak([mProcedure, procTts, procAnimationCtrl]),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(24),
                    backgroundColor: AppColor().secondary,
                  ),
                  child: AnimatedIcon(
                    icon: AnimatedIcons.play_pause,
                    progress: procAnimationCtrl,
                  ),
                ),
              ],
            ],
          ),

          const SizedBox(height: 8),

          /// Procedure List
          for (int idx = 0; idx < procedure.length; idx++) ...[
            Row(
              children: <Widget>[
                Text(
                  '${idx + 1}.',
                  style: theme.textTheme.bodyText1?.copyWith(
                    color: AppColor().secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    procedure[idx],
                    style: theme.textTheme.bodyText1?.copyWith(
                      color: AppColor().black,
                    ),
                  ),
                ),
              ],
            ),
            if (idx != procedure.length - 1) const SizedBox(height: 8.0),
          ],
        ],
      ),
    );
  }
}
