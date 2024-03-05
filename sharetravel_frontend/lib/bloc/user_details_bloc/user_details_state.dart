part of 'user_details_bloc.dart';

@immutable
sealed class UserDetailsState {}

final class UserDetailsInitial extends UserDetailsState {}

final class DoUserDetailsLoading extends UserDetailsState {}

final class DoUserDetailsSuccess extends UserDetailsState {
  final UserDetailsResponse userDetailsResponse;
  DoUserDetailsSuccess(this.userDetailsResponse);
}

final class DoUserDetailsError extends UserDetailsState {
  final String errorMessage;
  DoUserDetailsError(this.errorMessage);
}
