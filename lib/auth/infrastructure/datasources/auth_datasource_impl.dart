import 'dart:io';

import 'package:corpofit_mobile/auth/auth.dart';
import 'package:corpofit_mobile/auth/infrastructure/errors/auth_errors.dart';
import 'package:corpofit_mobile/auth/infrastructure/mappers/login_mapper.dart';
import 'package:corpofit_mobile/auth/infrastructure/mappers/user_mapper.dart';
import 'package:corpofit_mobile/config/constante/enviroment.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AuthDatasourceImpl implements AuthDatasources {
  late final Dio dio;

  AuthDatasourceImpl() {
    dio = createDio();
  }

  static String get baseUrl {
    var url = Environment.apiUri;
    if (kDebugMode && Platform.isAndroid) {
      url = url
          .replaceAll('localhost', '10.0.2.2')
          .replaceAll('127.0.0.1', '10.0.2.2');
    }
    return url;
  }

  static Dio createDio() {
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

  @override
  Future<Login> checkAuthStatus(String token) async {
    try {
      final response = await dio.get(
        'check-token-user',
        options: Options(headers: {'Authorization': token}),
      );

      final user = LoginMapper.loginJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError('Token inválido');
      }
      if (e.type == DioErrorType.connectionTimeout) {
        throw CustomError('Check internet connection');
      }
      throw Exception();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Login> login(Login login) async {
    try {
      final response = await dio.post('/login-user', data: login.toJson());

      final user = LoginMapper.loginJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError(
          e.response?.data['message'] ?? 'Incorrect credentials',
        );
      }
      if (e.type == DioErrorType.connectionTimeout) {
        throw CustomError('Check internet connection');
      }
      throw Exception();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<User> register(User user) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
