import 'package:corpofit_mobile/auth/infrastructure/datasources/auth_datasource_impl.dart';

import '../../domain/domain.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasources authDatasources;

  AuthRepositoryImpl({AuthDatasources? authDatasources})
    : authDatasources = authDatasources ?? AuthDatasourceImpl();

  @override
  Future<Login> checkAuthStatus(String token) {
    return authDatasources.checkAuthStatus(token);
  }

  @override
  Future<Login> login(Login login) {
    return authDatasources.login(login);
  }

  @override
  Future<User> register(User user) {
    return authDatasources.register(user);
  }
}
