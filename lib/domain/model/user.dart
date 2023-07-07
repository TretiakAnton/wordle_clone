class User {
  final String name;
  final String email;
  final String? photo;

  User({
    required this.name,
    required this.email,
    this.photo,
  });
}
