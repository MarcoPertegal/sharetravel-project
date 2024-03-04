part of 'trip_details_bloc.dart';

@immutable
sealed class TripDetailsState {}

final class TripDetailsInitial extends TripDetailsState {}

final class DoTripDetailsLoading extends TripDetailsState {}

final class DoTripDetailsSuccess extends TripDetailsState {
  final TripDetailsResponse tripDetailsResponse;
  DoTripDetailsSuccess(this.tripDetailsResponse);
}

final class DoTripDetailsError extends TripDetailsState {
  final String errorMessage;
  DoTripDetailsError(this.errorMessage);
}
