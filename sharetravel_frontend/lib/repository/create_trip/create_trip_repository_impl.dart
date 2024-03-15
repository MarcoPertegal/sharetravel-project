import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharetravel_frontend/model/dto/new_trip_dto.dart';
import 'package:sharetravel_frontend/model/response/create_trip_response/create_trip_response.dart';
import 'package:sharetravel_frontend/repository/create_trip/create_trip_repository.dart';

class CreateTripRepositoryImpl extends CreateTripRepository {
  final Client _httpClient = Client();

  @override
  Future<CreateTripResponse> createTrip(NewTripDto newTripDto) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found or something go wrong');
    }

    final jsonBody = jsonEncode(newTripDto.toJson());

    final response = await _httpClient.post(
      Uri.parse('http://10.0.2.2:8080/trip/new'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonBody,
    );
    if (response.statusCode == 201) {
      print(response.body);
      return CreateTripResponse.fromJson(response.body);
    } else {
      throw Exception('Failed to create a new trip');
    }
  }
}
