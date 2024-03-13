import 'package:sharetravel_frontend/model/dto/new_trip_dto.dart';
import 'package:sharetravel_frontend/model/response/create_trip_response/create_trip_response.dart';

abstract class CreateTripRepository {
  Future<CreateTripResponse> createTrip(NewTripDto newTripDto);
}
