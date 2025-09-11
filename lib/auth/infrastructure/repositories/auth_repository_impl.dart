import 'dart:async';
import 'dart:io';

import 'package:corpofit_mobile/auth/infrastructure/datasources/auth_datasource_impl.dart';
import 'package:corpofit_mobile/auth/infrastructure/errors/auth_exception.dart';
import 'package:flutter/foundation.dart';

import '../../domain/domain.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasources _authDatasources;

  AuthRepositoryImpl({AuthDatasources? authDatasources})
    : _authDatasources = authDatasources ?? AuthDatasourceImpl() {}

  @override
  Future<User> checkAuthStatus(String token) async {
    try {
      return await _authDatasources.checkAuthStatus(token);
    } catch (e, stackTrace) {
      _logError('checkAuthStatus', e, stackTrace);
      throw AuthException(
        message: 'Error verifying authentication status',
        originalError: e,
      );
    }
  }

  @override
  Future<User> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw const AuthException(message: "Email and password are required");
    }

    if (!_isValidEmail(email)) {
      throw const AuthException(message: 'Invalid email format');
    }

    try {
      return await _authDatasources.login(email, password);
    } catch (e, stackTrace) {
      _logError('login', e, stackTrace);

      if (e is SocketException) {
        throw const AuthException(message: "No internet connection");
      } else if (e is TimeoutException) {
        throw const AuthException(message: "Connection timeout");
      } else {
        throw AuthException(message: 'Login failed', originalError: e);
      }
    }
  }

  @override
  Future<User> register(User user) async {
    if (user.email.isEmpty) {
      throw const AuthException(message: "Email is required");
    }

    if (!_isValidEmail(user.email)) {
      throw const AuthException(message: "Invalid email format");
    }

    try {
      return await _authDatasources.register(user);
    } catch (e, stackTrace) {
      _logError('register', e, stackTrace);

      if (e is AuthException) {
        rethrow;
      }

      throw AuthException(message: "Registration failed", originalError: e);
    }
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');

    return emailRegex.hasMatch(email);
  }

  //TODO: Método privado para logging de errores
  void _logError(String method, dynamic error, StackTrace stackTrace) {
    debugPrint('AuthRepositoryImpl.$method error: $error');
    debugPrint('Stack trace: $stackTrace');
  }
}
