import 'dart:convert';

class CreateReserveResponse {
  String? id;
  DateTime? reserveDate;
  String? passengerId;
  String? tripId;

  CreateReserveResponse({
    this.id,
    this.reserveDate,
    this.passengerId,
    this.tripId,
  });

  factory CreateReserveResponse.fromMap(Map<String, dynamic> data) {
    return CreateReserveResponse(
      id: data['id'] as String?,
      reserveDate: data['reserveDate'] == null
          ? null
          : DateTime.parse(data['reserveDate'] as String),
      passengerId: data['passengerId'] as String?,
      tripId: data['tripId'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'reserveDate': reserveDate?.toIso8601String(),
        'passengerId': passengerId,
        'tripId': tripId,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CreateReserveResponse].
  factory CreateReserveResponse.fromJson(String data) {
    return CreateReserveResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CreateReserveResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
