import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:biteshaq/src/utils/notif_utils.dart';

void useFirebaseMessaging() => use(const _FirebaseMessagingHook());

class _FirebaseMessagingHook extends Hook<void> {
  const _FirebaseMessagingHook();

  @override
  _FirebaseMessagingHookState createState() => _FirebaseMessagingHookState();
}

class _FirebaseMessagingHookState
    extends HookState<void, _FirebaseMessagingHook> {
  // Set default values
  final FirebaseMessaging _fm = FirebaseMessaging.instance;

  @override
  void initHook() {
    super.initHook();
    FirebaseMessaging.onMessage.listen(NotifUtils().showRemoteNotification);
    FirebaseMessaging.onMessageOpenedApp
        .listen(NotifUtils().onBackgroundNotificationTapped);
  }

  @override
  void build(BuildContext context) {}

  @override
  void dispose() {
    super.dispose();
  }
}
