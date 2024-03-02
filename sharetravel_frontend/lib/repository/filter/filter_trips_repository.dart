import 'package:sharetravel_frontend/model/response/filter_trips_response/filter_trips_response.dart';

abstract class FilterTripsRepository {
  Future<FilterTripsResponse> tripsFilter(
      String departurePlace, String arrivalPlace, String departureDate);
}
