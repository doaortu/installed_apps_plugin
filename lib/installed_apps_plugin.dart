import 'package:installed_apps_plugin/data/installed_app.dart';
import 'package:installed_apps_plugin/installed_apps_plugin_method_channel.dart';

class InstalledAppsPlugin {
  final MethodChannelInstalledAppsPlugin _channel = MethodChannelInstalledAppsPlugin();
  Future<List<InstalledApp>> getInstalledApps() async {
    return _channel.getInstalledApps();
  }
}
