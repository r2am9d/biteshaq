// ignore_for_file: constant_identifier_names

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:biteshaq/src/themes/app_color.dart';

class NotifUtils {
  NotifUtils._internal();

  static const String BITESHAQ_CHANNEL = 'biteshaq_channel';
  static const String BITESHAQ_GROUP_CHANNEL = 'biteshaq_group_channel';

  static final FlutterLocalNotificationsPlugin _localNotification =
      FlutterLocalNotificationsPlugin();
  static final NotifUtils _instance = NotifUtils._internal();

  factory NotifUtils() => _instance;

  static NotificationDetails _notificationDetails() {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        NotifUtils.BITESHAQ_CHANNEL,
        'Basic Notifications',
        channelDescription: 'Notification channel for basic notifications',
        priority: Priority.max,
        importance: Importance.max,
        channelShowBadge: true,
        color: AppColor().red,
      ),
      iOS: const IOSNotificationDetails(),
    );
  }

  Future<void> init() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    const androidInitSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const iosInitSettings = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidInitSettings,
      iOS: iosInitSettings,
    );

    await _localNotification.initialize(initSettings);
  }

  void showNotification(RemoteMessage message) async {
    Map<String, dynamic> data = message.data;
    RemoteNotification? remoteNotif = message.notification;
    AndroidNotification? androidNotif = remoteNotif?.android;
    AppleNotification? appleNotif = remoteNotif?.apple;

    if (remoteNotif != null && (androidNotif != null || appleNotif != null)) {
      await _localNotification.show(
        remoteNotif.hashCode,
        remoteNotif.title,
        remoteNotif.body,
        _notificationDetails(),
      );
    }
  }

  void onOpenNotification(RemoteMessage message) {
    // @TODO: Implement navigation
    print('onOpenNotification: Notification opened');
  }

  void Function(RemoteMessage message) get getShowNotification =>
      showNotification;
  void Function(RemoteMessage message) get getOnOpenNotification =>
      onOpenNotification;
}
