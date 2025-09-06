import 'package:corpofit_mobile/auth/auth.dart';
import 'package:corpofit_mobile/auth/infrastructure/errors/auth_errors.dart';
import 'package:corpofit_mobile/auth/infrastructure/repositories/auth_repository_impl.dart';
import 'package:corpofit_mobile/utils/infrastructure/services/key_value_storage_service.dart';
import 'package:corpofit_mobile/utils/infrastructure/services/key_value_storage_servie_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();
  final keyValueStorageService = KeyValueStorageServiceImpl();

  return AuthNotifier(
    repository: authRepository,
    keyValueStorageService: keyValueStorageService,
  );
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository repository;
  final KeyValueStorageService keyValueStorageService;

  AuthNotifier({required this.repository, required this.keyValueStorageService})
    : super(AuthState()) {
    checkAuthStatus();
  }

  Future<void> loginUser(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final login = Login(email: email, password: password);
      final user = await repository.login(login);
      _setLoggedUser(user.token);
    } on CustomError catch (e) {
      logout(e.message);
    } catch (e) {
      logout('Error no controlado');
    }
  }

  void registerUser(User user) async {}

  void checkAuthStatus() async {
    final token = await keyValueStorageService.getKeyValue<String>('token');
    print("Token: $token");
    if (token == null) return logout();

    try {
      final user = await repository.checkAuthStatus(token);
      if (user.token.isEmpty) {
        logout();
        return;
      }

      _setLoggedUser(token);
    } catch (e) {
      logout();
    }
  }

  void _setLoggedUser(String token) async {
    await keyValueStorageService.setKeyValue('token', token);

    state = state.copyWith(
      status: AuthStatus.authenticated,
      user: null,
      errorMessage: '',
    );
  }

  Future<void> logout([String? errorMessage]) async {
    await keyValueStorageService.removeKey('token');

    state = state.copyWith(
      status: AuthStatus.notAuthenticated,
      user: null,
      errorMessage: errorMessage,
    );
  }
}

enum AuthStatus { cheking, authenticated, notAuthenticated }

class AuthState {
  final AuthStatus status;
  final Login? user;
  final String? errorMessage;

  AuthState({
    this.status = AuthStatus.cheking,
    this.user,
    this.errorMessage = '',
  });

  AuthState copyWith({AuthStatus? status, Login? user, String? errorMessage}) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
