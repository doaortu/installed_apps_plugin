import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:installed_apps_plugin/data/installed_app.dart';

import 'installed_apps_plugin_platform_interface.dart';

/// An implementation of [InstalledAppsPluginPlatform] that uses method channels.
class MethodChannelInstalledAppsPlugin extends InstalledAppsPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('installed_apps_plugin');

  @override
  Future<List<InstalledApp>> getInstalledApps() async {
    final List<dynamic> apps = await methodChannel.invokeMethod('getInstalledApps');
    return apps
        .map((app) => InstalledApp.fromMap(Map<String, dynamic>.from(app)))
        .toList();
  }
}
