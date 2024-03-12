class NewTripDto {
  String? departurePlace;
  String? arrivalPlace;
  String? departureTime;
  int? estimatedDuration;
  double? price;
  String? tripDescription;

  NewTripDto(
      {this.departurePlace,
      this.arrivalPlace,
      this.departureTime,
      this.estimatedDuration,
      this.price,
      this.tripDescription});

  NewTripDto.fromJson(Map<String, dynamic> json) {
    departurePlace = json['departurePlace'];
    arrivalPlace = json['arrivalPlace'];
    departureTime = json['departureTime'];
    estimatedDuration = json['estimatedDuration'];
    price = json['price'];
    tripDescription = json['tripDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['departurePlace'] = departurePlace;
    data['arrivalPlace'] = arrivalPlace;
    data['departureTime'] = departureTime;
    data['estimatedDuration'] = estimatedDuration;
    data['price'] = price;
    data['tripDescription'] = tripDescription;
    return data;
  }
}
