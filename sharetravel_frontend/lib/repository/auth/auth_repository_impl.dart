import 'dart:convert';
import 'package:http/http.dart';
import 'package:sharetravel_frontend/model/dto/login_dto.dart';
import 'package:sharetravel_frontend/model/response/login_response.dart';
import 'package:sharetravel_frontend/repository/auth/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final Client _httpClient = Client();

  @override
  Future<LoginResponse> login(LoginDto loginDto) async {
    final response = await _httpClient.post(
      Uri.parse('http://10.0.2.2:8080/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: loginDto.toJson(),
    );
    if (response.statusCode == 200) {
      return LoginResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to do login');
    }
  }
}
