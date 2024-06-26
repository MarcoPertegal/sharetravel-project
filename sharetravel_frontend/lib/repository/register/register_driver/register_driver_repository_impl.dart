import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharetravel_frontend/model/dto/register_dto.dart';
import 'package:sharetravel_frontend/model/response/register_response.dart';
import 'package:sharetravel_frontend/repository/register/register_driver/register_driver_repository.dart';

class RegisterDriverRepositoryImpl extends RegisterDriverRepository {
  final Client _httpClient = Client();

  @override
  Future<RegisterResponse> registerDriver(RegisterDto registerDto) async {
    final jsonBody = jsonEncode(registerDto.toJson());
    final response = await _httpClient.post(
      Uri.parse('http://localhost:8080/auth/register/driver'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonBody,
    );
    if (response.statusCode == 201) {
      final registerDriverResponse = RegisterResponse.fromJson(response.body);
      await _saveTokenToSharedPreferences(registerDriverResponse.token!);
      await _saveUserRolToSharedPreferences(registerDriverResponse.userRol!);
      return registerDriverResponse;
    } else {
      throw Exception('The username already exists or invalid credentials');
    }
  }

  Future<void> _saveTokenToSharedPreferences(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<void> _saveUserRolToSharedPreferences(String userRol) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userRol', userRol);
  }
}
