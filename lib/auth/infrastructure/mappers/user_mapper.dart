import '../../domain/domain.dart';

class UserMapper {
  static User userJsonToEntity(Map<String, dynamic> json) => User(
    message: _parseString(json['message']) ?? '',
    email: _parseString(json['email']) ?? '',
    token: _parseString(json['token']) ?? '',
    timestap: _parseString(json['timestap']) ?? '',
  );

  //TODO: Método auxiliar para manejar nulls
  static String? _parseString(dynamic value) {
    if (value == null) return '';
    if (value is String) return value;
    return value.toString();
  }
}
