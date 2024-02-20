part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

class DoRegisterEvent extends RegisterEvent {
  final String username;
  final String password;
  final String fullName;
  DoRegisterEvent(this.username, this.password, this.fullName);
}
