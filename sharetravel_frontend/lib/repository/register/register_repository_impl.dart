import 'dart:convert';
import 'package:http/http.dart';
import 'package:sharetravel_frontend/model/dto/register_dto.dart';
import 'package:sharetravel_frontend/model/response/register_response..dart';
import 'package:sharetravel_frontend/repository/register/register_repository.dart';

class RegisterRepositoryImpl extends RegisterRepository {
  final Client _httpClient = Client();

  @override
  Future<RegisterResponse> register(RegisterDto registerDto) async {
    final response = await _httpClient.post(
      Uri.parse('http://10.0.2.2:8080/auth/register'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: registerDto.toJson(),
    );
    if (response.statusCode == 200) {
      return RegisterResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to register');
    }
  }
}
