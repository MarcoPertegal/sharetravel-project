part of 'edit_trip_bloc.dart';

@immutable
sealed class EditTripState {}

final class EditTripInitial extends EditTripState {}

final class DoEditTripLoading extends EditTripState {}

final class DoEditTripSuccess extends EditTripState {
  final EditTripResponse editTripResponse;
  DoEditTripSuccess(this.editTripResponse);
}

final class DoEditTripError extends EditTripState {
  final String errorMessage;
  DoEditTripError(this.errorMessage);
}
