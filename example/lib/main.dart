import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:installed_apps_plugin/data/installed_app.dart';
import 'package:installed_apps_plugin/installed_apps_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<InstalledApp> _installedApps = [];
  final _installedAppsPlugin = InstalledAppsPlugin();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    List<InstalledApp> apps;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      apps = await _installedAppsPlugin.getInstalledApps();
    } on PlatformException {
      apps = [InstalledApp(name: 'Failed to get apps', id: '1')];
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _installedApps = apps;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text('Apps: $_installedApps\n'),
                TextButton(onPressed: (){
                  var htopApp = _installedApps.where((element) => element.name == 'Htop').first;
                  htopApp.launch();
                }, child: const Text('Launch Example App'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
