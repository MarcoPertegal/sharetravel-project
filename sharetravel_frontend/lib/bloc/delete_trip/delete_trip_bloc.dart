import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sharetravel_frontend/repository/delete_trip/delete_trip_repository.dart';

part 'delete_trip_event.dart';
part 'delete_trip_state.dart';

class DeleteTripBloc extends Bloc<DeleteTripEvent, DeleteTripState> {
  final DeleteTripRepository deleteTripRepository;
  DeleteTripBloc(this.deleteTripRepository) : super(DeleteTripInitial()) {
    on<DoDeleteTripEvent>(_doDeleteTrip);
  }

  Future<void> _doDeleteTrip(
      DoDeleteTripEvent event, Emitter<DeleteTripState> emit) async {
    emit(DoDeleteTripLoading());

    try {
      await deleteTripRepository.deleteTrip(event.id);
      emit(DoDeleteTripSuccess());
      return;
    } on Exception catch (e) {
      emit(DoDeleteTripError(e.toString()));
    }
  }
}
