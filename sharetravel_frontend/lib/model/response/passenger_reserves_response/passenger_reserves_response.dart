import 'dart:convert';

import 'reserve.dart';
import 'pageable.dart';
import 'sort.dart';

class PassengerReservesResponse {
  List<Reserve>? reserves;
  Pageable? pageable;
  int? totalPages;
  int? totalElements;
  bool? last;
  int? size;
  int? number;
  Sort? sort;
  int? numberOfElements;
  bool? first;
  bool? empty;

  PassengerReservesResponse({
    this.reserves,
    this.pageable,
    this.totalPages,
    this.totalElements,
    this.last,
    this.size,
    this.number,
    this.sort,
    this.numberOfElements,
    this.first,
    this.empty,
  });

  factory PassengerReservesResponse.fromMap(Map<String, dynamic> data) {
    return PassengerReservesResponse(
      reserves: (data['content'] as List<dynamic>?)
          ?.map((e) => Reserve.fromMap(e as Map<String, dynamic>))
          .toList(),
      pageable: data['pageable'] == null
          ? null
          : Pageable.fromMap(data['pageable'] as Map<String, dynamic>),
      totalPages: data['totalPages'] as int?,
      totalElements: data['totalElements'] as int?,
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
        'content': reserves?.map((e) => e.toMap()).toList(),
        'pageable': pageable?.toMap(),
        'totalPages': totalPages,
        'totalElements': totalElements,
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
  /// Parses the string and returns the resulting Json object as [PassengerReservesResponse].
  factory PassengerReservesResponse.fromJson(String data) {
    return PassengerReservesResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PassengerReservesResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
