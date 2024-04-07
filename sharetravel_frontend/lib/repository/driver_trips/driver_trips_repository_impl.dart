import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharetravel_frontend/model/response/driver_trips_response/driver_trips_response.dart';
import 'package:sharetravel_frontend/repository/driver_trips/driver_trips_repository.dart';

class DriverTripsRepositoryImpl extends DriverTripsRepository {
  final Client _httpClient = Client();

  @override
  Future<DriverTripsResponse> driverTrips() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found or something go wrong');
    }

    final response = await _httpClient.get(
      Uri.parse('http://localhost:8080/trip/driver'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      return DriverTripsResponse.fromJson(response.body);
    } else {
      final jsonResponse = json.decode(response.body);
      final errorMessage =
          jsonResponse['message'] as String? ?? "Unknown error";
      throw Exception(errorMessage);
    }
  }
}
