part of 'driver_ratings_bloc.dart';

@immutable
sealed class DriverRatingsState {}

final class DriverRatingsInitial extends DriverRatingsState {}

final class DoDriverRatingsLoading extends DriverRatingsState {}

final class DoDriverRatingsSuccess extends DriverRatingsState {
  final DriverRatingsResponse driverRatingsResponse;
  DoDriverRatingsSuccess(this.driverRatingsResponse);
}

final class DoDriverRatingsError extends DriverRatingsState {
  final String errorMessage;
  DoDriverRatingsError(this.errorMessage);
}
