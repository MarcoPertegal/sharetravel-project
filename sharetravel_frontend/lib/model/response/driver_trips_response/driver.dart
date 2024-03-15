import 'dart:convert';

class Driver {
  String? avatar;
  String? fullName;

  Driver({this.avatar, this.fullName});

  factory Driver.fromMap(Map<String, dynamic> data) => Driver(
        avatar: data['avatar'] as String?,
        fullName: data['fullName'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'avatar': avatar,
        'fullName': fullName,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Driver].
  factory Driver.fromJson(String data) {
    return Driver.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Driver] to a JSON string.
  String toJson() => json.encode(toMap());
}
