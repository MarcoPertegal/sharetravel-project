part of 'filter_trips_bloc.dart';

@immutable
sealed class FilterTripsEvent {}

class DoFilterTripsEvent extends FilterTripsEvent {
  final String departurePlace;
  final String arrivalPlace;
  final String departureDate;
  DoFilterTripsEvent(
      this.departurePlace, this.arrivalPlace, this.departureDate);
}
