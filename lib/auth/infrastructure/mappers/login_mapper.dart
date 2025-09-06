import 'package:corpofit_mobile/auth/domain/entities/login.dart';

class LoginMapper {
  static Login loginJsonToEntity(Map<String, dynamic> json) => Login(
    email: json['email'],
    password: json['password'],
    token: json['token'],
  );
}
