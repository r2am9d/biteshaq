import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:biteshaq/src/utils/notif_utils.dart';

FirebaseMessaging useFirebaseMessaging() => use(const _FirebaseMessagingHook());

class _FirebaseMessagingHook extends Hook<FirebaseMessaging> {
  const _FirebaseMessagingHook();

  @override
  _FirebaseMessagingHookState createState() => _FirebaseMessagingHookState();
}

class _FirebaseMessagingHookState
    extends HookState<FirebaseMessaging, _FirebaseMessagingHook> {
  // Set default values
  final FirebaseMessaging _fm = FirebaseMessaging.instance;

  @override
  void initHook() {
    FirebaseMessaging.onMessage.listen(NotifUtils().getShowNotification);
    FirebaseMessaging.onMessageOpenedApp
        .listen(NotifUtils().getOnOpenNotification);
  }

  @override
  FirebaseMessaging build(BuildContext context) => _fm;

  @override
  void dispose() {}
}
