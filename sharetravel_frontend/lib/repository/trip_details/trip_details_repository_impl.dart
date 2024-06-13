import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharetravel_frontend/model/response/trip_details_response/trip_details_response.dart';
import 'package:sharetravel_frontend/repository/trip_details/trip_details_repository.dart';

class TripDetailsRepositoryImpl extends TripDetailsRepository {
  final Client _httpClient = Client();

  @override
  Future<TripDetailsResponse> tripDetails(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found or something go wrong');
    }

    final response = await _httpClient.get(
      Uri.parse('http://localhost:8080/trip/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return TripDetailsResponse.fromJson(response.body);
    } else {
      throw Exception('Failed to find by id');
    }
  }
}
