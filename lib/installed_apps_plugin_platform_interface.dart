import 'package:installed_apps_plugin/data/installed_app.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'installed_apps_plugin_method_channel.dart';

abstract class InstalledAppsPluginPlatform extends PlatformInterface {
  /// Constructs a InstalledAppsPluginPlatform.
  InstalledAppsPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static InstalledAppsPluginPlatform _instance = MethodChannelInstalledAppsPlugin();

  /// The default instance of [InstalledAppsPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelInstalledAppsPlugin].
  static InstalledAppsPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [InstalledAppsPluginPlatform] when
  /// they register themselves.
  static set instance(InstalledAppsPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<List<InstalledApp>> getInstalledApps() async {
    throw UnimplementedError('getInstalledApps() has not been implemented.');
  }
}
