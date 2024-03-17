import 'dart:convert';

import 'package:http/http.dart';
import 'package:sharetravel_frontend/model/dto/login_dto.dart';
import 'package:sharetravel_frontend/model/response/login_response.dart';
import 'package:sharetravel_frontend/repository/auth/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl extends AuthRepository {
  final Client _httpClient = Client();

  @override
  Future<LoginResponse> login(LoginDto loginDto) async {
    final jsonBody = jsonEncode(loginDto.toJson());
    final response = await _httpClient.post(
      Uri.parse('http://localhost:8080/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonBody,
    );
    if (response.statusCode == 201) {
      final loginResponse = LoginResponse.fromJson(response.body);
      await _saveTokenToSharedPreferences(loginResponse.token!);
      await _saveUserRolToSharedPreferences(loginResponse.userRol!);

      return loginResponse;
    } else {
      throw Exception('Wrong user or password');
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
