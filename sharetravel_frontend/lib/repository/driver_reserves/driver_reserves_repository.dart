import 'package:sharetravel_frontend/model/response/driver_trips_response/driver_trips_response.dart';

abstract class DriverTripsRepository {
  Future<DriverTripsResponse> driverTrips();
}
