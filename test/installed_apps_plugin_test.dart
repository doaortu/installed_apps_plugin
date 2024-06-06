import 'package:flutter_test/flutter_test.dart';
import 'package:installed_apps_plugin/installed_apps_plugin.dart';
import 'package:installed_apps_plugin/installed_apps_plugin_platform_interface.dart';
import 'package:installed_apps_plugin/installed_apps_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockInstalledAppsPluginPlatform
    with MockPlatformInterfaceMixin
    implements InstalledAppsPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final InstalledAppsPluginPlatform initialPlatform = InstalledAppsPluginPlatform.instance;

  test('$MethodChannelInstalledAppsPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelInstalledAppsPlugin>());
  });

  test('getPlatformVersion', () async {
    InstalledAppsPlugin installedAppsPlugin = InstalledAppsPlugin();
    MockInstalledAppsPluginPlatform fakePlatform = MockInstalledAppsPluginPlatform();
    InstalledAppsPluginPlatform.instance = fakePlatform;

    expect(await installedAppsPlugin.getPlatformVersion(), '42');
  });
}
