import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sharetravel_frontend/model/dto/new_trip_dto.dart';
import 'package:sharetravel_frontend/model/response/create_trip_response/create_trip_response.dart';
import 'package:sharetravel_frontend/repository/create_trip/create_trip_repository.dart';

part 'create_trip_event.dart';
part 'create_trip_state.dart';

class CreateTripBloc extends Bloc<CreateTripEvent, CreateTripState> {
  final CreateTripRepository createTripRepository;
  CreateTripBloc(this.createTripRepository) : super(CreateTripInitial()) {
    on<DoCreateTripEvent>(_doCreateTrip);
  }

  Future<void> _doCreateTrip(
      DoCreateTripEvent event, Emitter<CreateTripState> emit) async {
    emit(DoCreateTripLoading());

    try {
      final NewTripDto newTripDto = NewTripDto(
          departurePlace: event.departurePlace,
          arrivalPlace: event.arrivalPlace,
          departureTime: event.departureTime,
          estimatedDuration: event.estimatedDuration,
          price: event.price,
          tripDescription: event.tripDescription);
      final response = await createTripRepository.createTrip(newTripDto);
      emit(DoCreateTripSuccess(response));
      return;
    } on Exception catch (e) {
      emit(DoCreateTripError(e.toString()));
    }
  }
}
