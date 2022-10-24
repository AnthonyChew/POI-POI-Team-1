class User {
  final String imagePath;
  final String name;
  final String id; //email

  const User({
    required this.imagePath,
    required this.name,
    required this.id,
  });

  User copy({
    String? imagePath,
    String? name,
    String? id,
  }) =>
      User(
        imagePath: imagePath ?? this.imagePath,
        name: name ?? this.name,
        id: id ?? this.id,
      );
}