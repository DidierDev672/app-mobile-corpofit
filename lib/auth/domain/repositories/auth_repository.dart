import 'package:corpofit_mobile/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<User> register(User user);
  Future<User> checkAuthStatus(String token);
}
