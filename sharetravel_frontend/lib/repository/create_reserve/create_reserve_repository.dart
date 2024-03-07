import 'package:sharetravel_frontend/model/dto/new_reserve_dto.dart';
import 'package:sharetravel_frontend/model/response/create_reserve_response.dart';

abstract class CreateReserveRepository {
  Future<CreateReserveResponse> createReserve(NewReserveDto newReserveDto);
}
