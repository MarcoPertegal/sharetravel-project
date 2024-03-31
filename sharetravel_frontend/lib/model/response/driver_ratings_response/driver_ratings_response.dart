import 'dart:convert';

import 'rating.dart';
import 'pageable.dart';
import 'sort.dart';

class DriverRatingsResponse {
  List<Rating>? ratings;
  Pageable? pageable;
  int? totalElements;
  int? totalPages;
  bool? last;
  int? size;
  int? number;
  Sort? sort;
  int? numberOfElements;
  bool? first;
  bool? empty;

  DriverRatingsResponse({
    this.ratings,
    this.pageable,
    this.totalElements,
    this.totalPages,
    this.last,
    this.size,
    this.number,
    this.sort,
    this.numberOfElements,
    this.first,
    this.empty,
  });

  factory DriverRatingsResponse.fromMap(Map<String, dynamic> data) {
    return DriverRatingsResponse(
      ratings: (data['content'] as List<dynamic>?)
          ?.map((e) => Rating.fromMap(e as Map<String, dynamic>))
          .toList(),
      pageable: data['pageable'] == null
          ? null
          : Pageable.fromMap(data['pageable'] as Map<String, dynamic>),
      totalElements: data['totalElements'] as int?,
      totalPages: data['totalPages'] as int?,
      last: data['last'] as bool?,
      size: data['size'] as int?,
      number: data['number'] as int?,
      sort: data['sort'] == null
          ? null
          : Sort.fromMap(data['sort'] as Map<String, dynamic>),
      numberOfElements: data['numberOfElements'] as int?,
      first: data['first'] as bool?,
      empty: data['empty'] as bool?,
    );
  }

  Map<String, dynamic> toMap() => {
        'content': ratings?.map((e) => e.toMap()).toList(),
        'pageable': pageable?.toMap(),
        'totalElements': totalElements,
        'totalPages': totalPages,
        'last': last,
        'size': size,
        'number': number,
        'sort': sort?.toMap(),
        'numberOfElements': numberOfElements,
        'first': first,
        'empty': empty,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [DriverRatingsResponse].
  factory DriverRatingsResponse.fromJson(String data) {
    return DriverRatingsResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [DriverRatingsResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
