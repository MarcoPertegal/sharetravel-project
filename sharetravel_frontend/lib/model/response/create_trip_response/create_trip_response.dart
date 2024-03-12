import 'dart:convert';

import 'driver.dart';

class CreateTripResponse {
  String? id;
  String? departurePlace;
  String? arrivalPlace;
  String? departureTime;
  int? estimatedDuration;
  String? arrivalTime;
  double? price;
  String? tripDescription;
  Driver? driver;
  dynamic reserves;

  CreateTripResponse({
    this.id,
    this.departurePlace,
    this.arrivalPlace,
    this.departureTime,
    this.estimatedDuration,
    this.arrivalTime,
    this.price,
    this.tripDescription,
    this.driver,
    this.reserves,
  });

  factory CreateTripResponse.fromMap(Map<String, dynamic> data) {
    return CreateTripResponse(
      id: data['id'] as String?,
      departurePlace: data['departurePlace'] as String?,
      arrivalPlace: data['arrivalPlace'] as String?,
      departureTime: data['departureTime'] as String?,
      estimatedDuration: data['estimatedDuration'] as int?,
      arrivalTime: data['arrivalTime'] as String?,
      price: (data['price'] as num?)?.toDouble(),
      tripDescription: data['tripDescription'] as String?,
      driver: data['driver'] == null
          ? null
          : Driver.fromMap(data['driver'] as Map<String, dynamic>),
      reserves: data['reserves'] as dynamic,
    );
  }

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
        'reserves': reserves,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CreateTripResponse].
  factory CreateTripResponse.fromJson(String data) {
    return CreateTripResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CreateTripResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
