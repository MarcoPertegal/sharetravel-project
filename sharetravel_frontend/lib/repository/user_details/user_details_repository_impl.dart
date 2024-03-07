import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharetravel_frontend/model/response/user_details_response.dart';
import 'package:sharetravel_frontend/repository/user_details/user_details_repository.dart';

class UserDetailsRepositoryImpl extends UserDetailsRepository {
  final Client _httpClient = Client();

  @override
  Future<UserDetailsResponse> userDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found or something go wrong');
    }

    final response = await _httpClient.get(
      Uri.parse('http://localhost:8080/user/details'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      return UserDetailsResponse.fromJson(response.body);
    } else {
      throw Exception('Failed to do user details request');
    }
  }
}
