part of 'user_details_bloc.dart';

@immutable
sealed class UserDetailsEvent {}

class DoUserDetailsEvent extends UserDetailsEvent {
  DoUserDetailsEvent();
}
