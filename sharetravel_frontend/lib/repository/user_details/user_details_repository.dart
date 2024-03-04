import 'package:sharetravel_frontend/model/response/user_details_response.dart';

abstract class UserDetailsRepository {
  Future<UserDetailsResponse> userDetails();
}
