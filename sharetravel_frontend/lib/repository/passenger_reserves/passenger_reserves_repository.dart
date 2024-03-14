import 'package:sharetravel_frontend/model/response/passenger_reserves_response/passenger_reserves_response.dart';

abstract class PassengerReservesRepository {
  Future<PassengerReservesResponse> passengerReserves();
}
