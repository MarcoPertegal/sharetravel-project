import 'dart:convert';

class NewReserveDto {
  String? tripId;

  NewReserveDto({this.tripId});

  NewReserveDto.fromJson(Map<String, dynamic> json) {
    tripId = json['tripId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tripId'] = tripId;
    return data;
  }
}
