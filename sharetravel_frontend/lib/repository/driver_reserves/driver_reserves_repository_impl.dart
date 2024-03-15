import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharetravel_frontend/model/response/driver_trips_response/driver_trips_response.dart';
import 'package:sharetravel_frontend/repository/driver_reserves/driver_reserves_repository.dart';

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
      Uri.parse('http://10.0.2.2:8080/trip/driver'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      return DriverTripsResponse.fromJson(response.body);
    } else if (response.statusCode == 404) {
      throw Exception('You have not booked any trips yet');
    } else {
      throw Exception('Failed to do passenger reserves request');
    }
  }
}
