import 'dart:convert';

class RegisterDto {
  String? username;
  String? password;
  String? fullName;

  RegisterDto({this.username, this.password, this.fullName});

  factory RegisterDto.fromMap(Map<String, dynamic> data) => RegisterDto(
        username: data['username'] as String?,
        password: data['password'] as String?,
        fullName: data['fullName'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'username': username,
        'password': password,
        'fullName': fullName,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [RegisterDto].
  factory RegisterDto.fromJson(String data) {
    return RegisterDto.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [RegisterDto] to a JSON string.
  String toJson() => json.encode(toMap());
}
