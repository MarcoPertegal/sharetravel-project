import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharetravel_frontend/model/dto/register_dto.dart';
import 'package:sharetravel_frontend/model/response/register_response..dart';
import 'package:sharetravel_frontend/repository/register/register_passenger/register_passenger_repository.dart';

class RegisterPassengerRepositoryImpl extends RegisterPassengerRepository {
  final Client _httpClient = Client();

  @override
  Future<RegisterResponse> registerPassenger(RegisterDto registerDto) async {
    final jsonBody = jsonEncode(registerDto.toJson());
    final response = await _httpClient.post(
      Uri.parse('http://10.0.2.2:8080/auth/register/passenger'),
      //'http://localhost:8080/auth/register/passenger'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonBody,
    );
    if (response.statusCode == 201) {
      final registerDriverResponse = RegisterResponse.fromJson(response.body);
      await _saveTokenToSharedPreferences(registerDriverResponse.token!);
      return registerDriverResponse;
    } else {
      throw Exception('Failed to register driver');
    }
  }

  Future<void> _saveTokenToSharedPreferences(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }
}
