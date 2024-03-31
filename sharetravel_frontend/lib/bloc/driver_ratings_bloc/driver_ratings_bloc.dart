import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sharetravel_frontend/model/response/driver_ratings_response/driver_ratings_response.dart';
import 'package:sharetravel_frontend/repository/driver_ratings/driver_ratings_repository.dart';

part 'driver_ratings_event.dart';
part 'driver_ratings_state.dart';

class DriverRatingsBloc extends Bloc<DriverRatingsEvent, DriverRatingsState> {
  final DriverRatingsRepository driverRatingsRepository;
  DriverRatingsBloc(this.driverRatingsRepository)
      : super(DriverRatingsInitial()) {
    on<DoDriverRatingsEvent>(_doDriverRatings);
  }

  Future<void> _doDriverRatings(
      DoDriverRatingsEvent event, Emitter<DriverRatingsState> emit) async {
    emit(DoDriverRatingsLoading());

    try {
      final response = await driverRatingsRepository.driverRatings();
      emit(DoDriverRatingsSuccess(response));
      return;
    } on Exception catch (e) {
      emit(DoDriverRatingsError(e.toString()));
    }
  }
}
