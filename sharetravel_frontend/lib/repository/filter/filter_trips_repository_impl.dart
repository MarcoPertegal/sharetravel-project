import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharetravel_frontend/model/response/filter_trips_list_response/filter_trips_list_response.dart';
import 'package:sharetravel_frontend/repository/filter/filter_trips_repository.dart';
import 'package:http/http.dart';

class FilterTripsRepositoryImpl extends FilterTripsRepository {
  final Client _httpClient = Client();

  @override
  Future<FilterTripsListResponse> tripsFilter(
      String departurePlace, String arrivalPlace, String departureDate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found or something go wrong');
    }

    final response = await _httpClient.get(
      Uri.parse(
          //'http://10.0.2.2:8080/trip/filter?departurePlace=$departurePlace&arrivalPlace=$arrivalPlace&departureDate=$departureDate'),
          'http://localhost:8080/trip/filter?departurePlace=$departurePlace&arrivalPlace=$arrivalPlace&departureDate=$departureDate'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      return FilterTripsListResponse.fromJson(response.body);
    } else {
      throw Exception('Failed to do the filter');
    }
  }
}
