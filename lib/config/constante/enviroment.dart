import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  Environment._();

  static final Map<String, String> _defaultValues = {
    'API_URL': 'http://127.0.0.1:8080',
  };

  static bool _isInitialized = false;

  static Future<void> initEnvironment({String fileName = '.env'}) async {
    try {
      await dotenv.load(fileName: fileName);
      _isInitialized = true;

      //TODO: Validar que las variables necesarias estén configuradas.
      _validateRequiredVariables();
    } catch (e) {
      _isInitialized = false;
      print('❌ Error loading environment variables: $e');
      throw Exception('Failed to load environment variables: $e');
    }
  }

  static void _validateRequiredVariables() {
    const requiredVariables = ['API_URL'];

    for (final variable in requiredVariables) {
      final value = dotenv.env[variable];
      if (value == null || value.isEmpty) {
        throw Exception('$variable is not configured in .env file');
      }

      if (variable == 'API_URL') {
        _validateUrl(value);
      }
    }
  }

  static void _validateUrl(String url) {
    try {
      final uri = Uri.parse(url);
      if (!uri.isAbsolute) {
        throw FormatException('URL must be absolute');
      }

      if (uri.scheme.isEmpty) {
        throw FormatException('URL must include a scheme (http/https)');
      }
    } catch (e) {
      throw Exception('Invalid API_URL format: $url. Error: $e');
    }
  }

  static String get apiUrl {
    _checkInitialization();

    final apiUrl = dotenv.env['API_URL'] ?? _defaultValues['API_URL']!;

    if (apiUrl.isEmpty) {
      throw Exception('API_URL is empty in .env file');
    }

    return apiUrl;
  }

  static Uri get apiUri {
    _checkInitialization();
    try {
      return Uri.parse(apiUrl);
    } catch (e) {
      throw Exception('Failed to parse API_URL: $e');
    }
  }

  static String get variable {
    _checkInitialization();
    return dotenv.env['VARIABLE'] ?? '';
  }

  static void _checkInitialization() {
    if (!_isInitialized) {
      throw Exception(
        "Environment not initialized. Call initEnvironment() first",
      );
    }
  }

  static bool get isInitialized => _isInitialized;

  //TODO: Método para desarrollo/debugging
  static void printAllVariables() {
    if (!_isInitialized) {
      print('Environment not initialized');
      return;
    }

    print('📋 Environment Variables:');
    dotenv.env.forEach((key, value) {
      print('  $key: $value');
    });
  }

  //TODO: Método para reinicialización (útil en test)
  static void reset() {
    _isInitialized = false;
  }
}
