import 'package:flutter/material.dart';
import 'package:infinity/Managers/notification_manager.dart';

class NotificationViewModel {
  static bool _isInit = false;

  static Future<bool> initializeNotification() async {
    if (NotificationManager().isInit == true) {
      debugPrint("already initaiozied notification manager");
      return false;
    }

    NotificationManager().setup();
    return true;
  }

  void createNewNotifi() {
    NotificationManager().showNotifi();
  }
}
