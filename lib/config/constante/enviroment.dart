import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  Environment._();

  static Future<void> initEnvironment() async {
    try {
      await dotenv.load(fileName: '.env');
      if (apiUri.isEmpty || apiUri == 'No está configurada el API_URI') {
        throw Exception('API_URI no está configurada en el archivo .env');
      }
    } catch (e) {
      print('Error al cargar variables de entorno: $e Code: ${e.hashCode}');
      throw Exception('Error al cargar variables de entorno: $e');
    }
  }

  static String get apiUri {
    final apiUri = dotenv.env['API_URL'] ?? '';
    if (apiUri.isEmpty) {
      return 'No está configurada el API_URL';
    }
    return apiUri;
  }

  static bool get isInitialized => dotenv.isInitialized;
}
