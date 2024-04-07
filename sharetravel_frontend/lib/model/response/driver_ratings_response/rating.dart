import 'dart:convert';

import 'passenger.dart';

class Rating {
  String? id;
  double? ratingValue;
  String? feedback;
  Passenger? passenger;

  Rating({this.id, this.ratingValue, this.feedback, this.passenger});

  factory Rating.fromMap(Map<String, dynamic> data) => Rating(
        id: data['id'] as String?,
        ratingValue: (data['ratingValue'] as num?)?.toDouble(),
        feedback: data['feedback'] as String?,
        passenger: data['passenger'] == null
            ? null
            : Passenger.fromMap(data['passenger'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'ratingValue': ratingValue,
        'feedback': feedback,
        'passenger': passenger?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Rating].
  factory Rating.fromJson(String data) {
    return Rating.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Rating] to a JSON string.
  String toJson() => json.encode(toMap());
}
