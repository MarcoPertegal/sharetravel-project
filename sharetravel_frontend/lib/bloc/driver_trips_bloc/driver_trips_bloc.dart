import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sharetravel_frontend/model/response/driver_trips_response/driver_trips_response.dart';
import 'package:sharetravel_frontend/repository/driver_trips/driver_trips_repository.dart';

part 'driver_trips_event.dart';
part 'driver_trips_state.dart';

class DriverTripsBloc extends Bloc<DriverTripsEvent, DriverTripsState> {
  final DriverTripsRepository driverTripsRepository;
  DriverTripsBloc(this.driverTripsRepository) : super(DriverTripsInitial()) {
    on<DoDriverTripsEvent>(_doDriverTrips);
  }

  Future<void> _doDriverTrips(
      DoDriverTripsEvent event, Emitter<DriverTripsState> emit) async {
    emit(DoDriverTripsLoading());

    try {
      final response = await driverTripsRepository.driverTrips();
      emit(DoDriverTripsSuccess(response));
      return;
    } on Exception catch (e) {
      emit(DoDriverTripsError(e.toString()));
    }
  }
}
