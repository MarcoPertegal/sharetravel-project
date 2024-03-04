part of 'filter_trips_bloc.dart';

@immutable
sealed class FilterTripsState {}

final class FilterTripsInitial extends FilterTripsState {}

final class DoFilterTripsLoading extends FilterTripsState {}

final class DoFilterTripsSuccess extends FilterTripsState {
  final FilterTripsListResponse filterTripsResponse;
  DoFilterTripsSuccess(this.filterTripsResponse);
}

final class DoFilterTripsNotFound extends FilterTripsState {
  final String errorMessage;
  DoFilterTripsNotFound(this.errorMessage);
}
