import 'package:flutter/material.dart';

class NotificationManager with WidgetsBindingObserver {
  static final _instance = NotificationManager._internal();

  factory NotificationManager() {
    return _instance;
  }

  NotificationManager._internal();
}
