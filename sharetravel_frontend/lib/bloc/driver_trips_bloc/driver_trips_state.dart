part of 'driver_trips_bloc.dart';

@immutable
sealed class DriverTripsState {}

final class DriverTripsInitial extends DriverTripsState {}

final class DoDriverTripsLoading extends DriverTripsState {}

final class DoDriverTripsSuccess extends DriverTripsState {
  final DriverTripsResponse driverTripsResponse;
  DoDriverTripsSuccess(this.driverTripsResponse);
}

final class DoDriverTripsError extends DriverTripsState {
  final String errorMessage;
  DoDriverTripsError(this.errorMessage);
}
