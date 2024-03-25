import 'dart:convert';

import 'driver.dart';

class Trip {
  String? id;
  String? departurePlace;
  String? arrivalPlace;
  String? departureTime;
  int? estimatedDuration;
  String? arrivalTime;
  int? price;
  String? tripDescription;
  Driver? driver;

  Trip({
    this.id,
    this.departurePlace,
    this.arrivalPlace,
    this.departureTime,
    this.estimatedDuration,
    this.arrivalTime,
    this.price,
    this.tripDescription,
    this.driver,
  });

  factory Trip.fromMap(Map<String, dynamic> data) => Trip(
        id: data['id'] as String?,
        departurePlace: data['departurePlace'] as String?,
        arrivalPlace: data['arrivalPlace'] as String?,
        departureTime: data['departureTime'] as String?,
        estimatedDuration: data['estimatedDuration'] as int?,
        arrivalTime: data['arrivalTime'] as String?,
        price: data['price'] as int?,
        tripDescription: data['tripDescription'] as String?,
        driver: data['driver'] == null
            ? null
            : Driver.fromMap(data['driver'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'departurePlace': departurePlace,
        'arrivalPlace': arrivalPlace,
        'departureTime': departureTime,
        'estimatedDuration': estimatedDuration,
        'arrivalTime': arrivalTime,
        'price': price,
        'tripDescription': tripDescription,
        'driver': driver?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Trip].
  factory Trip.fromJson(String data) {
    return Trip.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Trip] to a JSON string.
  String toJson() => json.encode(toMap());
}
