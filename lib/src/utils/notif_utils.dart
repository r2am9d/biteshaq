// ignore_for_file: constant_identifier_names

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:biteshaq/src/themes/app_color.dart';

class NotifUtils {
  NotifUtils._internal();

  static const String BITESHAQ_CHANNEL = 'biteshaq_channel';
  static const String BITESHAQ_GROUP_CHANNEL = 'biteshaq_group_channel';

  static final FirebaseMessaging _firebaseMsg = FirebaseMessaging.instance;
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
    await _firebaseMsg.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    const androidInitSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final iosInitSettings = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: _onIosForegroundNotificationTapped,
    );

    final initSettings = InitializationSettings(
      android: androidInitSettings,
      iOS: iosInitSettings,
    );

    await _localNotification.initialize(
      initSettings,
      onSelectNotification: _onAndroidForegroundNotificationTapped,
    );
  }

  void _showNotification(RemoteMessage message) async {
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
        payload: data.toString(),
      );
    }
  }

  Future<String?> getToken() async => await _firebaseMsg.getToken();

  void _onIosForegroundNotificationTapped(
      int id, String? title, String? body, String? payload) async {
    // @TODO: IOS_NOTIFICATION_TAPPED
  }

  void _onAndroidForegroundNotificationTapped(String? payload) async {
    // @TODO: ANDR_NOTIFICATION_TAPPED
  }

  void _onBackgroundNotificationTapped(RemoteMessage message) async {
    // @TODO: BG_NOTIFICATION_TAPPED
  }

  void Function(RemoteMessage message) get showNotification =>
      _showNotification;
  void Function(RemoteMessage message) get onBackgroundNotificationTapped =>
      _onBackgroundNotificationTapped;
}
