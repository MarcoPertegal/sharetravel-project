part of 'delete_trip_bloc.dart';

@immutable
sealed class DeleteTripState {}

final class DeleteTripInitial extends DeleteTripState {}

final class DoDeleteTripLoading extends DeleteTripState {}

final class DoDeleteTripSuccess extends DeleteTripState {
  DoDeleteTripSuccess();
}

final class DoDeleteTripError extends DeleteTripState {
  final String errorMessage;
  DoDeleteTripError(this.errorMessage);
}
