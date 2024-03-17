part of 'edit_trip_bloc.dart';

@immutable
sealed class EditTripEvent {}

class DoEditTripEvent extends EditTripEvent {
  final String id;
  final String departurePlace;
  final String arrivalPlace;
  final String departureTime;
  final int estimatedDuration;
  final double price;
  final String tripDescription;

  DoEditTripEvent(
      this.id,
      this.departurePlace,
      this.arrivalPlace,
      this.departureTime,
      this.estimatedDuration,
      this.price,
      this.tripDescription);
}
