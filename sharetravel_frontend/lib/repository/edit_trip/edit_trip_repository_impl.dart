import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharetravel_frontend/model/dto/new_trip_dto.dart';
import 'package:sharetravel_frontend/model/response/edit_trip_response/edit_trip_response.dart';
import 'package:sharetravel_frontend/repository/edit_trip/edit_trip_repository.dart';

class EditTripRepositoryImpl extends EditTripRepository {
  final Client _httpClient = Client();

  @override
  Future<EditTripResponse> editTrip(String id, NewTripDto editTripDto) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found or something go wrong');
    }

    final jsonBody = jsonEncode(editTripDto.toJson());

    final response = await _httpClient.put(
      Uri.parse('http://localhost:8080/trip/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonBody,
    );
    if (response.statusCode == 201) {
      print(response.body);
      return EditTripResponse.fromJson(response.body);
    } else {
      throw Exception('Failed to edit trip');
    }
  }
}
