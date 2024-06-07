# Installed Apps Plugin
This is a Flutter plugin project named installed_apps_plugin. It is designed to provide functionality related to installed applications on a device.

### Features
- Fetches a list of installed applications on linux.
- Run selected app.

### Getting Started
To use this plugin, add installed_apps_plugin as a dependency in your pubspec.yaml file.
```yaml
dependencies:
  installed_apps_plugin: ^0.0.2
```

### Usage
Import installed_apps_plugin in your Dart file:
```dart
import 'package:installed_apps_plugin/data/installed_app.dart';
import 'package:installed_apps_plugin/installed_apps_plugin.dart';
```

and use the async `getInstalledApps` method whenever you want:
```dart
final _installedAppsPlugin = InstalledAppsPlugin();
List<InstalledApp> apps = await _installedAppsPlugin.getInstalledApps();

// to run the app just call the launch() from InstalledApp
apps[0].launch()
```

You can then use the plugin's methods to fetch installed apps and platform version.

### Platform Support
This plugin has support for **Linux platform**. It uses `gio` gtk c++ binding to get installed apps.

### Testing
The plugin includes unit tests for the C portion of the plugin's implementation. These tests can be run from the command line once the plugin's example app has been built.

### Contributing
Contributions are welcome! Please read the contributing guidelines before getting started.

### License
This project is licensed under the terms of the MIT license.

### Contact
For any issues or suggestions, please open an issue on the GitHub repository.

### More Information
For more information, please refer to the example provided in this repository.
