import 'package:sharetravel_frontend/model/dto/new_rating_dto.dart';
import 'package:sharetravel_frontend/model/response/create_rating_response/create_rating_response.dart';

abstract class CreateRatingRepository {
  Future<CreateRatingResponse> createRating(NewRatingDto newRatingDto);
}
