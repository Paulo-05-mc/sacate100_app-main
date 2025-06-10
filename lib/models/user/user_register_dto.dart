class UserRegisterDto {
  final String username;
  final String email;
  final String password;

  UserRegisterDto({
    required this.username,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }

  factory UserRegisterDto.fromJson(Map<String, dynamic> json) {
    return UserRegisterDto(
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }
}