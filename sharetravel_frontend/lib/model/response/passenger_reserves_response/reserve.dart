import 'dart:convert';

import 'trip.dart';

class Reserve {
  String? reserveDate;
  Trip? trip;

  Reserve({this.reserveDate, this.trip});

  factory Reserve.fromMap(Map<String, dynamic> data) => Reserve(
        reserveDate: data['reserveDate'] as String?,
        trip: data['trip'] == null
            ? null
            : Trip.fromMap(data['trip'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'reserveDate': reserveDate,
        'trip': trip?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Content].
  factory Reserve.fromJson(String data) {
    return Reserve.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Content] to a JSON string.
  String toJson() => json.encode(toMap());
}
