import 'package:sharetravel_frontend/model/response/driver_ratings_response/driver_ratings_response.dart';

abstract class DriverRatingsRepository {
  Future<DriverRatingsResponse> driverRatings();
}
