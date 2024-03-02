part of 'register_passenger_bloc.dart';

@immutable
sealed class RegisterPassengerState {}

final class RegisterPassengerInitial extends RegisterPassengerState {}

final class DoRegisterPassengerLoading extends RegisterPassengerState {}

final class DoRegisterPassengerSuccess extends RegisterPassengerState {
  final RegisterResponse userRegisterPassenger;
  DoRegisterPassengerSuccess(this.userRegisterPassenger);
}

final class DoRegisterPassengerError extends RegisterPassengerState {
  final String errorMessage;
  DoRegisterPassengerError(this.errorMessage);
}
