import 'dart:convert';

class UserDetailsResponse {
  String? id;
  String? email;
  String? phoneNumber;
  String? personalDescription;
  String? avatar;
  String? fullName;
  String? averageRating;

  UserDetailsResponse({
    this.id,
    this.email,
    this.phoneNumber,
    this.personalDescription,
    this.avatar,
    this.fullName,
    this.averageRating,
  });

  factory UserDetailsResponse.fromMap(Map<String, dynamic> data) {
    return UserDetailsResponse(
      id: data['id'] as String?,
      email: data['email'] as String?,
      phoneNumber: data['phoneNumber'] as String?,
      personalDescription: data['personalDescription'] as String?,
      avatar: data['avatar'] as String?,
      fullName: data['fullName'] as String?,
      averageRating: data['averageRating'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'email': email,
        'phoneNumber': phoneNumber,
        'personalDescription': personalDescription,
        'avatar': avatar,
        'fullName': fullName,
        'averageRating': averageRating,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [UserDetailsResponse].
  factory UserDetailsResponse.fromJson(String data) {
    return UserDetailsResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [UserDetailsResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
