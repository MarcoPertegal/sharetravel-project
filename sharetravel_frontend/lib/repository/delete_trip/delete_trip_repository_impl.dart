import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharetravel_frontend/repository/delete_trip/delete_trip_repository.dart';

class DeleteTripRepositoryImpl extends DeleteTripRepository {
  final Client _httpClient = Client();

  @override
  Future deleteTrip(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found or something go wrong');
    }

    final response = await _httpClient.delete(
      Uri.parse('http://localhost:8080/trip/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 204) {
    } else {
      throw Exception('Failed to delete the trip');
    }
  }
}
