import 'dart:io';

import 'package:corpofit_mobile/auth/auth.dart';
import 'package:corpofit_mobile/auth/infrastructure/errors/auth_errors.dart';
import 'package:corpofit_mobile/auth/infrastructure/mappers/user_mapper.dart';
import 'package:corpofit_mobile/config/constante/enviroment.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AuthDatasourceImpl implements AuthDatasources {
  late final Dio dio;

  AuthDatasourceImpl() {
    dio = createDio();
  }

  static Dio createDio() {
    final baseUrl = _getBaseUrl();

    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          error: true,
          requestHeader: true,
          responseHeader: true,
        ),
      );
    }

    return dio;
  }

  static String _getBaseUrl() {
    try {
      var url = Environment.apiUrl;

      if (kDebugMode && Platform.isAndroid) {
        url = url
            .replaceAll('localhost', '10.0.2.2')
            .replaceAll('127.0.0.1', '10.0.2.2');
      }

      if (kDebugMode) {
        print('🌐 Server URL: $url');
      }

      return url;
    } catch (e) {
      throw Exception('Failed to get base URL: $e');
    }
  }

  @override
  Future<User> checkAuthStatus(String token) async {
    try {
      final response = await dio.post(
        '/check-token-user',
        options: Options(headers: {'Authorization': token}),
      );
      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } catch (e) {
      if (e is DioError) {
        if (e.response?.statusCode == 401) {
          throw CustomError('Token incorrecto');
        }
      }

      throw Exception();
    }
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await dio.post(
        '/login-user',
        data: {'email': email, 'password': password},
      );
      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } catch (e) {
      if (e is DioError) {
        if (e.response?.statusCode == 401) {
          throw CustomError('Credenciales incorrectas');
        }
      }
      throw Exception(e);
    }
  }

  @override
  Future<User> register(User user) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
