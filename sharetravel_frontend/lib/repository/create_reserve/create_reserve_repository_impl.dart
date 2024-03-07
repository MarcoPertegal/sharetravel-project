import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharetravel_frontend/model/dto/new_reserve_dto.dart';
import 'package:sharetravel_frontend/model/response/create_reserve_response.dart';
import 'package:sharetravel_frontend/repository/create_reserve/create_reserve_repository.dart';

class CreateReserveRepositoryImpl extends CreateReserveRepository {
  final Client _httpClient = Client();

  @override
  Future<CreateReserveResponse> createReserve(
      NewReserveDto newReserveDto) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found or something go wrong');
    }

    final jsonBody = jsonEncode(newReserveDto.toJson());

    final response = await _httpClient.post(
      Uri.parse('http://localhost:8080/reserve/new'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonBody,
    );

    if (response.statusCode == 201) {
      print(response.body);
      return CreateReserveResponse.fromJson(response.body);
    } else {
      throw Exception('Failed to create reserve');
    }
  }
}
