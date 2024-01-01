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

  @HiveField(4)
  final String? section;

  SmartShedUser({
    required this.id,
    required this.name,
    required this.email,
    required this.position,
    this.section,
  });

  factory SmartShedUser.fromJson(Map<String, dynamic> json) {
    return SmartShedUser(
      id: json['id'] ?? json['_id'],
      name: json['name'],
      email: json['email'],
      position: json['position'],
      section: json.containsKey('section') &&
              (json['section'] as String).trim().isNotEmpty
          ? json['section']
          : null,
    );
  }
}
