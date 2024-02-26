import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharetravel_frontend/model/response/filter_trips_response/filter_trips_response.dart';
import 'package:sharetravel_frontend/repository/filter/filter_trips_repository.dart';

part 'filter_trips_event.dart';
part 'filter_trips_state.dart';

class FilterTripsBloc extends Bloc<FilterTripsEvent, FilterTripsState> {
  final FilterTripsRepository filterTripsRepository;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  FilterTripsBloc(this.filterTripsRepository) : super(FilterTripsInitial()) {
    on<DoFilterTripsEvent>(_doTripsFilter);
  }

  Future<void> _doTripsFilter(
      DoFilterTripsEvent event, Emitter<FilterTripsState> emit) async {
    emit(DoFilterTripsLoading());

    try {
      final response = await filterTripsRepository.tripsFilter(
          event.departurePlace, event.arrivalPlace, event.departureDate);
      emit(DoFilterTripsSuccess(response));
      return;
    } on Exception catch (e) {
      emit(DoFilterTripsError(e.toString()));
    }
  }
}
