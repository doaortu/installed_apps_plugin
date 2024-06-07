import 'dart:io';

class InstalledApp {
  final String id;
  final String name;
  final String? iconPath; // Nullable

  InstalledApp({required this.name, this.iconPath, required this.id });

  factory InstalledApp.fromMap(Map<String, dynamic> map) {
    return InstalledApp(
      name: map['name'],
      iconPath: map['iconPath'], // This can be null
      id: map['id'],
    );
  }

  Future<void> launch() async {
    await Process.run('gtk-launch', [id]);
  }

  @override
  String toString() {
    return "name: $name, iconPath: $iconPath, id: $id";
  }
}
