import 'dart:io';

class InstalledApp {
  final String id;
  final String name;
  final String? description;
  final String? iconPath; // Nullable

  InstalledApp({required this.name, this.iconPath, required this.id , this.description});

  factory InstalledApp.fromMap(Map<String, dynamic> map) {
    return InstalledApp(
      name: map['name'],
      iconPath: map['iconPath'], // This can be null
      id: map['id'],
      description: map['description'],
    );
  }

  Future<void> launch() async {
    await Process.start('gtk-launch', [id]);
  }

  @override
  String toString() {
    return "name: $name, description: $description, iconPath: $iconPath, id: $id";
  }
}
