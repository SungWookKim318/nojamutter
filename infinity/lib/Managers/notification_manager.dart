import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:infinity/main.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationManager with WidgetsBindingObserver {
  static final _instance = NotificationManager._internal();

  factory NotificationManager() {
    return _instance;
  }

  final _plugin = FlutterLocalNotificationsPlugin();

  bool _isInit = false;
  bool get isInit => _isInit;
  static var _curruntId = 0;
  NotificationManager._internal();

  void setup() async {
    if (isInit) {
      debugPrint("already initaiozied notification manager");
      return;
    }

    // const androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');
    const androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher',
        onDidReceiveLocalNotification: onDidReceiveAndroidCallback);
    const iOSSetting = DarwinInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
        onDidReceiveLocalNotification: onDidReceiveAppleCallback);
    await _plugin.initialize(
        const InitializationSettings(android: androidSetting, iOS: iOSSetting),
        onDidReceiveBackgroundNotificationResponse: receiveBackgroundCallback,
        onDidReceiveNotificationResponse: receiveCallback);
    _isInit = true;
  }

  static void receiveCallback(NotificationResponse details) {
    debugPrint("receiveCallback was Called");
  }

  static void receiveBackgroundCallback(NotificationResponse details) {
    debugPrint("receiveBackgroundCallback was Called");
  }

  static void onDidReceiveAndroidCallback(
      int id, String? title, String? body, String? payload) {
    debugPrint("onDidReceiveAndroidCallback was Called");
    if (_curruntId < 5) {
      debugPrint("request new local notification");
      NotificationManager().showNotifi();
    } else {
      debugPrint("too many request. escape function");
    }
  }

  static void onDidReceiveAppleCallback(
      int id, String? title, String? body, String? payload) {
    debugPrint("onDidReceiveAppleCallback was Called");
    if (_curruntId < 5) {
      debugPrint("request new local notification");
      NotificationManager().showNotifi();
    } else {
      debugPrint("too many request. escape function");
    }
  }

  void showNotifi() async {
    var androidDetail =
        const AndroidNotificationDetails("channelId", "channelName");
    var iosDetail = const DarwinNotificationDetails();
    var details = NotificationDetails(android: androidDetail, iOS: iosDetail);
    if (_isInit != true) {
      return;
    }

    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.deleteNotificationChannelGroup('id');
    await _plugin.zonedSchedule(_curruntId, "test Title - $_curruntId",
        "test test test test", _requestNotifiacationTime(), details,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
    _curruntId += 1;
  }

  tz.TZDateTime _requestNotifiacationTime({int seconds = 10}) {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Seoul'));

    return tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds));
  }
}
