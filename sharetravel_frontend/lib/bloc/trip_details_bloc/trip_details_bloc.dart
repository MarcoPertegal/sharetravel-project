import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sharetravel_frontend/model/response/trip_details_response/trip_details_response.dart';
import 'package:sharetravel_frontend/repository/trip/trip_details_repository.dart';

part 'trip_details_event.dart';
part 'trip_details_state.dart';

class TripDetailsBloc extends Bloc<TripDetailsEvent, TripDetailsState> {
  final TripDetailsRepository tripDetailsRepository;

  TripDetailsBloc(this.tripDetailsRepository) : super(TripDetailsInitial()) {
    on<DoTripDetailsEvent>(_doTripDetails);
  }

  Future<void> _doTripDetails(
      DoTripDetailsEvent event, Emitter<TripDetailsState> emit) async {
    emit(DoTripDetailsLoading());

    try {
      final response = await tripDetailsRepository.tripDetails(event.id);
      emit(DoTripDetailsSuccess(response));
      return;
    } on Exception catch (e) {
      emit(DoTripDetailsError(e.toString()));
    }
  }
}
