import 'package:hive/hive.dart';

part 'hive_adapters/user.g.dart';

@HiveType(typeId: 1)
class SmartShedUser extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String position;

  SmartShedUser({
    required this.id,
    required this.name,
    required this.email,
    required this.position,
  });

  factory SmartShedUser.fromJson(Map<String, dynamic> json) {
    return SmartShedUser(
      id: json['id'] ?? json['_id'],
      name: json['name'],
      email: json['email'],
      position: json['position'],
    );
  }
}
