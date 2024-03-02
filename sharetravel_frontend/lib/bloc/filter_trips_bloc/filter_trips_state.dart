part of 'filter_trips_bloc.dart';

@immutable
sealed class FilterTripsState {}

final class FilterTripsInitial extends FilterTripsState {}

final class DoFilterTripsLoading extends FilterTripsState {}

final class DoFilterTripsSuccess extends FilterTripsState {
  final FilterTripsListResponse filterTripsResponse;
  DoFilterTripsSuccess(this.filterTripsResponse);
}

final class DoFilterTripsError extends FilterTripsState {
  final String errorMessage;
  DoFilterTripsError(this.errorMessage);
}
