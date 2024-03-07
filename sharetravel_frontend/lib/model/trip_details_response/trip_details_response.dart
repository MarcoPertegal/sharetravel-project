import 'dart:convert';

import 'driver.dart';
import 'reserve.dart';

class TripDetailsResponse {
  String? id;
  String? departurePlace;
  String? arrivalPlace;
  String? departureTime;
  int? estimatedDuration;
  String? arrivalTime;
  double? price;
  String? tripDescription;
  Driver? driver;
  List<Reserve>? reserves;

  TripDetailsResponse({
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

  factory TripDetailsResponse.fromMap(Map<String, dynamic> data) {
    return TripDetailsResponse(
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
      reserves: (data['reserves'] as List<dynamic>?)
          ?.map((e) => Reserve.fromMap(e as Map<String, dynamic>))
          .toList(),
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
        'reserves': reserves?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TripDetailsResponse].
  factory TripDetailsResponse.fromJson(String data) {
    return TripDetailsResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TripDetailsResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
