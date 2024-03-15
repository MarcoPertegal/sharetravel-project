import 'dart:convert';

import 'package:sharetravel_frontend/model/response/driver_trips_response/trip.dart';

import 'pageable.dart';
import 'sort.dart';

class DriverTripsResponse {
  List<Trip>? trips;
  Pageable? pageable;
  bool? last;
  int? totalPages;
  int? totalElements;
  bool? first;
  int? size;
  int? number;
  Sort? sort;
  int? numberOfElements;
  bool? empty;

  DriverTripsResponse({
    this.trips,
    this.pageable,
    this.last,
    this.totalPages,
    this.totalElements,
    this.first,
    this.size,
    this.number,
    this.sort,
    this.numberOfElements,
    this.empty,
  });

  factory DriverTripsResponse.fromMap(Map<String, dynamic> data) {
    return DriverTripsResponse(
      trips: (data['content'] as List<dynamic>?)
          ?.map((e) => Trip.fromMap(e as Map<String, dynamic>))
          .toList(),
      pageable: data['pageable'] == null
          ? null
          : Pageable.fromMap(data['pageable'] as Map<String, dynamic>),
      last: data['last'] as bool?,
      totalPages: data['totalPages'] as int?,
      totalElements: data['totalElements'] as int?,
      first: data['first'] as bool?,
      size: data['size'] as int?,
      number: data['number'] as int?,
      sort: data['sort'] == null
          ? null
          : Sort.fromMap(data['sort'] as Map<String, dynamic>),
      numberOfElements: data['numberOfElements'] as int?,
      empty: data['empty'] as bool?,
    );
  }

  Map<String, dynamic> toMap() => {
        'content': trips?.map((e) => e.toMap()).toList(),
        'pageable': pageable?.toMap(),
        'last': last,
        'totalPages': totalPages,
        'totalElements': totalElements,
        'first': first,
        'size': size,
        'number': number,
        'sort': sort?.toMap(),
        'numberOfElements': numberOfElements,
        'empty': empty,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [DriverTripsResponse].
  factory DriverTripsResponse.fromJson(String data) {
    return DriverTripsResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [DriverTripsResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
