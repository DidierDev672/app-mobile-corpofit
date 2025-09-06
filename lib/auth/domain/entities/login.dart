class Login {
  final String? uuid;
  final String email;
  final String password;
  final String token;

  const Login({
    this.uuid,
    required this.email,
    required this.password,
    this.token = '',
  });

  Map<String, dynamic> toJson() {
    return {'uuid': uuid, 'email': email, 'password': password, 'token': token};
  }

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      uuid: json['uuid'],
      email: json['email'],
      password: json['password'],
      token: json['token'] ?? '',
    );
  }
}
