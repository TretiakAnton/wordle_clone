import 'package:hive/hive.dart';

part 'wordle_user.g.dart';

@HiveType(typeId: 0)
class WordleUser {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String id;

  @HiveField(3)
  final String? photo;

  WordleUser({
    required this.name,
    required this.email,
    required this.id,
    this.photo,
  });
}
