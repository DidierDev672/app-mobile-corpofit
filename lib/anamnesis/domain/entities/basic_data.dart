import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class BasicData {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final double height;
  @HiveField(3)
  final double weight;
  @HiveField(3)
  final String gender;
  @HiveField(4)
  final DateTime birthDate;
  @HiveField(5)
  final String country;
  @HiveField(6)
  final String city;
  @HiveField(7)
  final String address;
  @HiveField(8)
  final String region;

  @HiveField(9)
  final DateTime createdAt;

  BasicData({
    this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.gender,
    required this.birthDate,
    required this.country,
    required this.city,
    required this.address,
    required this.region,
    required this.createdAt,
  });
}
