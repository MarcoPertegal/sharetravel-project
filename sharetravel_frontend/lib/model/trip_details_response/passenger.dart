import 'dart:convert';

class Passenger {
  String? avatar;
  String? fullName;

  Passenger({this.avatar, this.fullName});

  factory Passenger.fromMap(Map<String, dynamic> data) => Passenger(
        avatar: data['avatar'] as String?,
        fullName: data['fullName'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'avatar': avatar,
        'fullName': fullName,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Passenger].
  factory Passenger.fromJson(String data) {
    return Passenger.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Passenger] to a JSON string.
  String toJson() => json.encode(toMap());
}
