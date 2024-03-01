part of 'register_passenger_bloc.dart';

@immutable
sealed class RegisterPassengerEvent {}

class DoRegisterPassengerEvent extends RegisterPassengerEvent {
  final String username;
  final String password;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String personalDescription;
  final String avatar;
  DoRegisterPassengerEvent(this.username, this.password, this.fullName,
      this.email, this.phoneNumber, this.personalDescription, this.avatar);
}
