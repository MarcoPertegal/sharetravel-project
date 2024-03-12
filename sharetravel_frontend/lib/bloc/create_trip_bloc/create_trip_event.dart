part of 'create_trip_bloc.dart';

@immutable
sealed class CreateTripEvent {}

class DoCreateTripEvent extends CreateTripEvent {
  final String departurePlace;
  final String arrivalPlace;
  final String departureTime;
  final int estimatedDuration;
  final double price;
  final String tripDescription;

  DoCreateTripEvent(this.departurePlace, this.arrivalPlace, this.departureTime,
      this.estimatedDuration, this.price, this.tripDescription);
}
