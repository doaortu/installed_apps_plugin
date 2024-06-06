import 'package:flutter/services.dart';
import 'installed_apps_plugin_platform_interface.dart';

class InstalledApp {
  final String name;
  final String? iconPath; // Nullable

  InstalledApp({required this.name, this.iconPath});

  factory InstalledApp.fromMap(Map<String, dynamic> map) {
    return InstalledApp(
      name: map['name'],
      iconPath: map['iconPath'], // This can be null
    );
  }

  @override
  String toString() {
    return "name: $name, iconPath: $iconPath";
  }
}

class InstalledAppsPlugin {
  static const MethodChannel _channel = MethodChannel('installed_apps_plugin');

  static Future<List<InstalledApp>> getInstalledApps() async {
    final List<dynamic> apps = await _channel.invokeMethod('getInstalledApps');
    return apps
        .map((app) => InstalledApp.fromMap(Map<String, dynamic>.from(app)))
        .toList();
  }

  Future<String?> getPlatformVersion() {
    return InstalledAppsPluginPlatform.instance.getPlatformVersion();
  }
}
