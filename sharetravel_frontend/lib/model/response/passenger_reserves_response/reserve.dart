import 'dart:convert';

import 'trip.dart';

class Reserve {
  String? id;
  String? reserveDate;
  Trip? trip;

  Reserve({this.id, this.reserveDate, this.trip});

  factory Reserve.fromMap(Map<String, dynamic> data) => Reserve(
        id: data['id'] as String?,
        reserveDate: data['reserveDate'] as String?,
        trip: data['trip'] == null
            ? null
            : Trip.fromMap(data['trip'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'reserveDate': reserveDate,
        'trip': trip?.toMap(),
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
