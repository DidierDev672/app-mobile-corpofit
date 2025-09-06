import 'package:corpofit_mobile/auth/domain/entities/login.dart';
import 'package:corpofit_mobile/auth/domain/entities/user.dart';

abstract class AuthDatasources {
  Future<Login> login(Login login);
  Future<User> register(User user);
  Future<Login> checkAuthStatus(String token);
}
