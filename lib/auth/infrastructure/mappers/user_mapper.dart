import '../../domain/domain.dart';

class UserMapper {
  static User userJsonToEntity(Map<String, dynamic> json) => User(
    uuid: json['uuid'],
    fullName: json['fullName'],
    numberDocument: json['numberDocument'],
    phone: json['phone'],
    email: json['email'],
    address: json['address'],
    birthDate: json['birthDate'],
    password: json['password'],
    photo: json['photo'],
  );
}
