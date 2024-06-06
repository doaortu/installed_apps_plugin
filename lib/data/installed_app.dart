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
