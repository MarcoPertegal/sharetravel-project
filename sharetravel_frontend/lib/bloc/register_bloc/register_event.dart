part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

class DoRegisterEvent extends RegisterEvent {
  final String username;
  final String password;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String personalDescription;
  final String avatar;
  DoRegisterEvent(this.username, this.password, this.fullName, this.email,
      this.phoneNumber, this.personalDescription, this.avatar);
}
