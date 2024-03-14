import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sharetravel_frontend/model/response/passenger_reserves_response/passenger_reserves_response.dart';
import 'package:sharetravel_frontend/repository/passenger_reserves/passenger_reserves_repository.dart';

part 'passenger_reserves_event.dart';
part 'passenger_reserves_state.dart';

class PassengerReservesBloc
    extends Bloc<PassengerReservesEvent, PassengerReservesState> {
  final PassengerReservesRepository passengerReservesRepository;
  PassengerReservesBloc(this.passengerReservesRepository)
      : super(PassengerReservesInitial()) {
    on<DoPassengerReservesEvent>(_doPassengerReserves);
  }

  Future<void> _doPassengerReserves(DoPassengerReservesEvent event,
      Emitter<PassengerReservesState> emit) async {
    emit(DoPassengerReservesLoading());

    try {
      final response = await passengerReservesRepository.passengerReserves();
      emit(DoPassengerReservesSuccess(response));
      return;
    } on Exception catch (e) {
      emit(DoPassengerReservesError(e.toString()));
    }
  }
}
