import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sharetravel_frontend/model/dto/new_trip_dto.dart';
import 'package:sharetravel_frontend/model/response/edit_trip_response/edit_trip_response.dart';
import 'package:sharetravel_frontend/repository/edit_trip/edit_trip_repository.dart';

part 'edit_trip_event.dart';
part 'edit_trip_state.dart';

class EditTripBloc extends Bloc<EditTripEvent, EditTripState> {
  final EditTripRepository editTripRepository;
  EditTripBloc(this.editTripRepository) : super(EditTripInitial()) {
    on<DoEditTripEvent>(_doEditTripEvent);
  }

  Future<void> _doEditTripEvent(
      DoEditTripEvent event, Emitter<EditTripState> emit) async {
    emit(DoEditTripLoading());

    try {
      final NewTripDto editTripDto = NewTripDto(
          departurePlace: event.departurePlace,
          arrivalPlace: event.arrivalPlace,
          departureTime: event.departureTime,
          estimatedDuration: event.estimatedDuration,
          price: event.price,
          tripDescription: event.tripDescription);
      final response = await editTripRepository.editTrip(event.id, editTripDto);
      emit(DoEditTripSuccess(response));
      return;
    } on Exception catch (e) {
      emit(DoEditTripError(e.toString()));
    }
  }
}
