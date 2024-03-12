import 'dart:convert';

class LoginResponse {
  String? id;
  String? username;
  String? avatar;
  String? fullName;
  String? userRol;
  String? token;
  String? refreshToken;

  LoginResponse({
    this.id,
    this.username,
    this.avatar,
    this.fullName,
    this.userRol,
    this.token,
    this.refreshToken,
  });

  factory LoginResponse.fromMap(Map<String, dynamic> data) => LoginResponse(
        id: data['id'] as String?,
        username: data['username'] as String?,
        avatar: data['avatar'] as String?,
        fullName: data['fullName'] as String?,
        userRol: data['userRol'] as String?,
        token: data['token'] as String?,
        refreshToken: data['refreshToken'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'username': username,
        'avatar': avatar,
        'fullName': fullName,
        'userRol': userRol,
        'token': token,
        'refreshToken': refreshToken,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LoginResponse].
  factory LoginResponse.fromJson(String data) {
    return LoginResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LoginResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
