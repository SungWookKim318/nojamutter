import 'package:flutter/material.dart';
import 'package:infinity/ViewModels/notification_viewmodel.dart';
import 'package:infinity/Views/home_view.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationViewModel.initializeNotification();
  runApp(const MyApp());
}

final plugin = FlutterLocalNotificationsPlugin();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Startup Name Generator', home: HomeView());
  }
}
