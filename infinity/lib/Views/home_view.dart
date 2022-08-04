import 'package:flutter/material.dart';
import 'package:infinity/ViewModels/notification_viewmodel.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: createScaffold(context));
  }

  Scaffold createScaffold(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // ignore: prefer_const_literals_to_create_immutables
        children: <Widget>[const Text("Test My Home View")],
      )),
      floatingActionButton: FloatingActionButton(
          onPressed: _pressPush, child: const Icon(Icons.add)),
    );
  }

  void _pressPush() {
    NotificationViewModel viewModel = NotificationViewModel();
    viewModel.createNewNotifi();
    debugPrint("press Push button");
  }
}
