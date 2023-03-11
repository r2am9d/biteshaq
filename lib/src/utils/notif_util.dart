// ignore_for_file: constant_identifier_names

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:biteshaq/src/themes/app_color.dart';

class NotifUtil {
  factory NotifUtil() => _instance;

  NotifUtil._internal();

  static const String BITESHAQ_CHANNEL = 'biteshaq_channel';
  static const String BITESHAQ_GROUP_CHANNEL = 'biteshaq_group_channel';

  static final FirebaseMessaging _firebaseMsg = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _flutterLocalNotif =
      FlutterLocalNotificationsPlugin();
  static final NotifUtil _instance = NotifUtil._internal();

  static NotificationDetails _notificationDetails() {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        NotifUtil.BITESHAQ_CHANNEL,
        'Basic Notifications',
        channelDescription: 'Notification channel for basic notifications',
        priority: Priority.max,
        importance: Importance.max,
        channelShowBadge: true,
        color: AppColor().red,
      ),
      iOS: const DarwinNotificationDetails(),
    );
  }

  Future<void> init() async {
    await _firebaseMsg.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    const androidInitSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final iosInitSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: _onIosForegroundNotifTapped,
    );

    final initSettings = InitializationSettings(
      android: androidInitSettings,
      iOS: iosInitSettings,
    );

    await _flutterLocalNotif.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onAndroidForegroundNotifTapped,
    );
  }

  Future<void> _showRemoteNotification(RemoteMessage message) async {
    final data = message.data;
    final remoteNotif = message.notification;
    final androidNotif = remoteNotif?.android;
    final appleNotif = remoteNotif?.apple;

    if (remoteNotif != null && (androidNotif != null || appleNotif != null)) {
      await _flutterLocalNotif.show(
        remoteNotif.hashCode,
        remoteNotif.title,
        remoteNotif.body,
        _notificationDetails(),
        payload: data.toString(),
      );
    }
  }

  Future<String?> getToken() async => _firebaseMsg.getToken();

  Future<void> _onIosForegroundNotifTapped(
      int id, String? title, String? body, String? payload) async {
    // TODO: IOS_NOTIFICATION_TAPPED
  }

  Future<void> _onAndroidForegroundNotifTapped(
      NotificationResponse notifResp) async {
    // TODO: ANDR_NOTIFICATION_TAPPED
    final notifPayload = notifResp.payload;
    switch (notifResp.notificationResponseType) {
      case NotificationResponseType.selectedNotification:
        break;
      case NotificationResponseType.selectedNotificationAction:
        break;
    }
  }

  Future<void> _onBackgroundNotificationTapped(RemoteMessage message) async {
    // TODO: BG_NOTIFICATION_TAPPED
  }

  void Function(RemoteMessage message) get showRemoteNotification =>
      _showRemoteNotification;
  void Function(RemoteMessage message) get onBackgroundNotificationTapped =>
      _onBackgroundNotificationTapped;
}