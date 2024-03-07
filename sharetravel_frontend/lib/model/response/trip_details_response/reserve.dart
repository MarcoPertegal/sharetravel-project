import 'dart:convert';

import 'passenger.dart';

class Reserve {
  String? reserveDate;
  Passenger? passenger;

  Reserve({this.reserveDate, this.passenger});

  factory Reserve.fromMap(Map<String, dynamic> data) => Reserve(
        reserveDate: data['reserveDate'] as String?,
        passenger: data['passenger'] == null
            ? null
            : Passenger.fromMap(data['passenger'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'reserveDate': reserveDate,
        'passenger': passenger?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Reserve].
  factory Reserve.fromJson(String data) {
    return Reserve.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Reserve] to a JSON string.
  String toJson() => json.encode(toMap());
}
