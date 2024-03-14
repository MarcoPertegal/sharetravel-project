part of 'passenger_reserves_bloc.dart';

@immutable
sealed class PassengerReservesState {}

final class PassengerReservesInitial extends PassengerReservesState {}

final class DoPassengerReservesLoading extends PassengerReservesState {}

final class DoPassengerReservesSuccess extends PassengerReservesState {
  final PassengerReservesResponse passengerReservesResponse;
  DoPassengerReservesSuccess(this.passengerReservesResponse);
}

final class DoPassengerReservesError extends PassengerReservesState {
  final String errorMessage;
  DoPassengerReservesError(this.errorMessage);
}
