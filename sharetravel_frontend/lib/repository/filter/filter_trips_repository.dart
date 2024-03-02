import 'package:sharetravel_frontend/model/response/filter_trips_list_response/filter_trips_list_response.dart';

abstract class FilterTripsRepository {
  Future<FilterTripsListResponse> tripsFilter(
      String departurePlace, String arrivalPlace, String departureDate);
}
