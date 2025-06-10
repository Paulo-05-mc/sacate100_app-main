class UserLoginDto {
  final String email;
  final String password;

  UserLoginDto({
    required this.email, 
    required this.password
  });

  Map<String, dynamic> toJson() => {    
    'emailaddress': email,
    'password': password,    
  };

  factory UserLoginDto.fromJson(Map<String, dynamic> json) {
    return UserLoginDto(
      email: json['emailaddress'] as String,
      password: json['password'] as String,
    );
  }
}