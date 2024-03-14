part of 'passenger_reserves_bloc.dart';

@immutable
sealed class PassengerReservesEvent {}

class DoPassengerReservesEvent extends PassengerReservesEvent {
  DoPassengerReservesEvent();
}
