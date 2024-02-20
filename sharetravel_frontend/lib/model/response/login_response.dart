import 'dart:convert';

class LoginResponse {
  String? id;
  String? username;
  String? fullName;
  String? createdAt;
  String? token;
  String? refreshToken;

  LoginResponse({
    this.id,
    this.username,
    this.fullName,
    this.createdAt,
    this.token,
    this.refreshToken,
  });

  factory LoginResponse.fromMap(Map<String, dynamic> data) => LoginResponse(
        id: data['id'] as String?,
        username: data['username'] as String?,
        fullName: data['fullName'] as String?,
        createdAt: data['createdAt'] as String?,
        token: data['token'] as String?,
        refreshToken: data['refreshToken'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'username': username,
        'fullName': fullName,
        'createdAt': createdAt,
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
