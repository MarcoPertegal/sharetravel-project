import 'dart:convert';

import 'driver.dart';
import 'passenger.dart';

class CreateRatingResponse {
  String? id;
  DateTime? ratingDate;
  int? ratingValue;
  String? feedback;
  Driver? driver;
  Passenger? passenger;

  CreateRatingResponse({
    this.id,
    this.ratingDate,
    this.ratingValue,
    this.feedback,
    this.driver,
    this.passenger,
  });

  factory CreateRatingResponse.fromMap(Map<String, dynamic> data) {
    return CreateRatingResponse(
      id: data['id'] as String?,
      ratingDate: data['ratingDate'] == null
          ? null
          : DateTime.parse(data['ratingDate'] as String),
      ratingValue: data['ratingValue'] as int?,
      feedback: data['feedback'] as String?,
      driver: data['driver'] == null
          ? null
          : Driver.fromMap(data['driver'] as Map<String, dynamic>),
      passenger: data['passenger'] == null
          ? null
          : Passenger.fromMap(data['passenger'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'ratingDate': ratingDate?.toIso8601String(),
        'ratingValue': ratingValue,
        'feedback': feedback,
        'driver': driver?.toMap(),
        'passenger': passenger?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CreateRatingResponse].
  factory CreateRatingResponse.fromJson(String data) {
    return CreateRatingResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CreateRatingResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
