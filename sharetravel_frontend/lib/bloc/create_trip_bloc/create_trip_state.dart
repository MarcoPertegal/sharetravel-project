part of 'create_trip_bloc.dart';

@immutable
sealed class CreateTripState {}

final class CreateTripInitial extends CreateTripState {}

final class DoCreateTripLoading extends CreateTripState {}

final class DoCreateTripSuccess extends CreateTripState {
  final CreateTripResponse createTripResponse;
  DoCreateTripSuccess(this.createTripResponse);
}

final class DoCreateTripError extends CreateTripState {
  final String errorMessage;
  DoCreateTripError(this.errorMessage);
}
