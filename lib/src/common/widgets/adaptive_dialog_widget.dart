import 'package:flutter/material.dart';

class AdaptiveDialogWidget extends StatelessWidget {
  const AdaptiveDialogWidget({
    super.key,
    required this.title,
    required this.content,
    required this.dialogContext,
  });

  final Widget title;
  final Widget content;
  final BuildContext dialogContext;

  @override
  Widget build(BuildContext context) {
    final mQ = MediaQuery.of(dialogContext);

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: mQ.size.height * 0.75),
      child: AlertDialog(
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        title: title,
        content: SizedBox(
          width: mQ.size.width * 0.85,
          child: content,
        ),
      ),
    );
  }
}
