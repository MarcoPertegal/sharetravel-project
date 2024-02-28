import 'dart:convert';

import 'trip.dart';
import 'pageable.dart';
import 'sort.dart';

class FilterTripsResponse {
  List<Trip>? trips;
  Pageable? pageable;
  bool? last;
  int? totalElements;
  int? totalPages;
  int? size;
  int? number;
  Sort? sort;
  bool? first;
  int? numberOfElements;
  bool? empty;

  FilterTripsResponse({
    this.trips,
    this.pageable,
    this.last,
    this.totalElements,
    this.totalPages,
    this.size,
    this.number,
    this.sort,
    this.first,
    this.numberOfElements,
    this.empty,
  });

  factory FilterTripsResponse.fromMap(Map<String, dynamic> data) {
    return FilterTripsResponse(
      trips: (data['content'] as List<dynamic>?)
          ?.map((e) => Trip.fromMap(e as Map<String, dynamic>))
          .toList(),
      pageable: data['pageable'] == null
          ? null
          : Pageable.fromMap(data['pageable'] as Map<String, dynamic>),
      last: data['last'] as bool?,
      totalElements: data['totalElements'] as int?,
      totalPages: data['totalPages'] as int?,
      size: data['size'] as int?,
      number: data['number'] as int?,
      sort: data['sort'] == null
          ? null
          : Sort.fromMap(data['sort'] as Map<String, dynamic>),
      first: data['first'] as bool?,
      numberOfElements: data['numberOfElements'] as int?,
      empty: data['empty'] as bool?,
    );
  }

  Map<String, dynamic> toMap() => {
        'content': trips?.map((e) => e.toMap()).toList(),
        'pageable': pageable?.toMap(),
        'last': last,
        'totalElements': totalElements,
        'totalPages': totalPages,
        'size': size,
        'number': number,
        'sort': sort?.toMap(),
        'first': first,
        'numberOfElements': numberOfElements,
        'empty': empty,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [FilterTripsResponse].
  factory FilterTripsResponse.fromJson(String data) {
    return FilterTripsResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [FilterTripsResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
