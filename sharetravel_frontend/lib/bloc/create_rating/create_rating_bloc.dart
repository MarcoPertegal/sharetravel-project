import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sharetravel_frontend/model/dto/new_rating_dto.dart';
import 'package:sharetravel_frontend/model/response/create_rating_response/create_rating_response.dart';
import 'package:sharetravel_frontend/repository/create_rating/create_rating_repository.dart';

part 'create_rating_event.dart';
part 'create_rating_state.dart';

class CreateRatingBloc extends Bloc<CreateRatingEvent, CreateRatingState> {
  final CreateRatingRepository createRatingRepository;

  CreateRatingBloc(this.createRatingRepository) : super(CreateRatingInitial()) {
    on<DoCreateRatingEvent>(_doCreateRating);
  }

  Future<void> _doCreateRating(
      DoCreateRatingEvent event, Emitter<CreateRatingState> emit) async {
    emit(DoCreateRatingLoading());

    try {
      final NewRatingDto newRatingDto = NewRatingDto(
          ratingValue: event.ratingValue,
          feedback: event.feedback,
          driverId: event.driverId);
      final response = await createRatingRepository.createRating(newRatingDto);
      emit(DoCreateRatingSuccess(response));
      return;
    } on Exception catch (e) {
      emit(DoCreateRatingError(e.toString()));
    }
  }
}
