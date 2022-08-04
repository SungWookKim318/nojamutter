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
  var _curruntId = 0;
  NotificationManager._internal();

  void setup() async {
    if (isInit) {
      debugPrint("already initaiozied notification manager");
      return;
    }

    const androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOSSetting = IOSInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true);
    await _plugin.initialize(
        const InitializationSettings(android: androidSetting, iOS: iOSSetting));
    _isInit = true;
  }

  void showNotifi() async {
    var androidDetail = AndroidNotificationDetails("channelId", "channelName");
    var iosDetail = IOSNotificationDetails();
    var details = NotificationDetails(android: androidDetail, iOS: iosDetail);
    if (_isInit != true) {
      return;
    }

    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.deleteNotificationChannelGroup('id');
    await _plugin.zonedSchedule(_curruntId, "test Title - $_curruntId",
        "test test test test", _setNotiTime(), details,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
    _curruntId += 1;
  }

  tz.TZDateTime _setNotiTime() {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Seoul'));

    final now = tz.TZDateTime.now(tz.local);
    // var scheduledDate =
    //     tz.TZDateTime(tz.local, now.year, now.month, now.day, 10, 0);

    // return scheduledDate;
    return tz.TZDateTime.now(tz.local).add(Duration(seconds: 10));
  }
}
