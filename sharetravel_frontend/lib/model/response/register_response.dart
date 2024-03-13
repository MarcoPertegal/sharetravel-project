import 'dart:convert';

class RegisterResponse {
  String? id;
  String? username;
  String? avatar;
  String? fullName;
  String? userRol;
  String? createdAt;
  String? token;
  String? refreshToken;

  RegisterResponse({
    this.id,
    this.username,
    this.avatar,
    this.fullName,
    this.userRol,
    this.createdAt,
    this.token,
    this.refreshToken,
  });

  factory RegisterResponse.fromMap(Map<String, dynamic> data) {
    return RegisterResponse(
      id: data['id'] as String?,
      username: data['username'] as String?,
      avatar: data['avatar'] as String?,
      fullName: data['fullName'] as String?,
      userRol: data['userRol'] as String?,
      createdAt: data['createdAt'] as String?,
      token: data['token'] as String?,
      refreshToken: data['refreshToken'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'username': username,
        'avatar': avatar,
        'fullName': fullName,
        'userRol': userRol,
        'createdAt': createdAt,
        'token': token,
        'refreshToken': refreshToken,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [RegisterResponse].
  factory RegisterResponse.fromJson(String data) {
    return RegisterResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [RegisterResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
