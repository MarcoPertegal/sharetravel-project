import 'package:sharetravel_frontend/model/dto/new_trip_dto.dart';
import 'package:sharetravel_frontend/model/response/edit_trip_response/edit_trip_response.dart';

abstract class EditTripRepository {
  Future<EditTripResponse> editTrip(String id, NewTripDto editTripDto);
}
