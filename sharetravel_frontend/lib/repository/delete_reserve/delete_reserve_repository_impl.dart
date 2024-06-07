import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharetravel_frontend/repository/delete_reserve/delete_reserve_repository.dart';

class DeleteReserveRepositoryImpl extends DeleteReserveRepository {
  final Client _httpClient = Client();

  @override
  Future deleteReserve(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found or something go wrong');
    }

    final response = await _httpClient.delete(
      Uri.parse('http://localhost:8080/reserve/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 204) {
    } else {
      throw Exception('Failed to delete the reserve');
    }
  }
}
