import 'package:sharetravel_frontend/model/dto/register_dto.dart';
import 'package:sharetravel_frontend/model/response/register_response..dart';

abstract class RegisterPassengerRepository {
  Future<RegisterResponse> registerPassenger(RegisterDto registerDto);
}
