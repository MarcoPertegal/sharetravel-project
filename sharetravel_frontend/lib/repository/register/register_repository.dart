import 'package:sharetravel_frontend/model/dto/register_dto.dart';
import 'package:sharetravel_frontend/model/response/register_response..dart';

abstract class RegisterRepository {
  Future<RegisterResponse> register(RegisterDto registerDto);
}
