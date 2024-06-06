import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:installed_apps_plugin/installed_apps_plugin_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelInstalledAppsPlugin platform = MethodChannelInstalledAppsPlugin();
  const MethodChannel channel = MethodChannel('installed_apps_plugin');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
