import 'dart:convert';

class RegisterResponse {
  String? id;
  String? username;
  dynamic avatar;
  String? fullName;
  String? createdAt;

  RegisterResponse({
    this.id,
    this.username,
    this.avatar,
    this.fullName,
    this.createdAt,
  });

  factory RegisterResponse.fromMap(Map<String, dynamic> data) {
    return RegisterResponse(
      id: data['id'] as String?,
      username: data['username'] as String?,
      avatar: data['avatar'] as dynamic,
      fullName: data['fullName'] as String?,
      createdAt: data['createdAt'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'username': username,
        'avatar': avatar,
        'fullName': fullName,
        'createdAt': createdAt,
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
