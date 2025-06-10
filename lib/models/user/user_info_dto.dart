// lib/models/user/user_info_dto.dart

class UserInfoDto {
  final int id;
  final String username;
  final String email;
  final String role;

  UserInfoDto({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
  });

  factory UserInfoDto.fromJson(Map<String, dynamic> json) {
    return UserInfoDto(
      id: json['id'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
    );
  }
}
