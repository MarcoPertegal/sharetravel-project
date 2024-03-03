part of 'trip_details_bloc.dart';

@immutable
sealed class TripDetailsEvent {}

class DoTripDetailsEvent extends TripDetailsEvent {
  final String id;
  DoTripDetailsEvent(this.id);
}
