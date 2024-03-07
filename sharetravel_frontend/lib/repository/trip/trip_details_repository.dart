import 'package:sharetravel_frontend/model/trip_details_response/trip_details_response.dart';

abstract class TripDetailsRepository {
  Future<TripDetailsResponse> tripDetails(String id);
}
