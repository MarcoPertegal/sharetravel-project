import 'package:sharetravel_frontend/model/dto/login_dto.dart';
import 'package:sharetravel_frontend/model/response/login_response.dart';

abstract class AuthRepository {
  Future<LoginResponse> login(LoginDto loginDto);
}
