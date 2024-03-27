class NewRatingDto {
  double? ratingValue;
  String? feedback;
  String? driverId;

  NewRatingDto({this.ratingValue, this.feedback, this.driverId});

  NewRatingDto.fromJson(Map<String, dynamic> json) {
    ratingValue = json['ratingValue'];
    feedback = json['feedback'];
    driverId = json['driverId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ratingValue'] = ratingValue;
    data['feedback'] = feedback;
    data['driverId'] = driverId;
    return data;
  }
}
