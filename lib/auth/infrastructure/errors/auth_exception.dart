class AuthException implements Exception {
  final String message;
  final dynamic originalError;

  const AuthException({required this.message, this.originalError});

  @override
  String toString() => 'AuthException: $message';
}
