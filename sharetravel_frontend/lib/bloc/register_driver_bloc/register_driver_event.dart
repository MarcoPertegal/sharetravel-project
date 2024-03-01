part of 'register_driver_bloc.dart';

@immutable
sealed class RegisterDriverEvent {}

class DoRegisterDriverEvent extends RegisterDriverEvent {
  final String username;
  final String password;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String personalDescription;
  final String avatar;
  DoRegisterDriverEvent(this.username, this.password, this.fullName, this.email,
      this.phoneNumber, this.personalDescription, this.avatar);
}
