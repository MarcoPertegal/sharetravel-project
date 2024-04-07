import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharetravel_frontend/model/response/driver_ratings_response/driver_ratings_response.dart';
import 'package:sharetravel_frontend/repository/driver_ratings/driver_ratings_repository.dart';

class DriverRatingsRepositoryImpl extends DriverRatingsRepository {
  final Client _httpClient = Client();

  @override
  Future<DriverRatingsResponse> driverRatings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found or something go wrong');
    }

    final response = await _httpClient.get(
      Uri.parse('http://localhost:8080/rating/driver'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      return DriverRatingsResponse.fromJson(response.body);
    } else {
      final jsonResponse = json.decode(response.body);
      final errorMessage =
          jsonResponse['message'] as String? ?? "Unknown error";
      throw Exception(errorMessage);
    }
  }
}
