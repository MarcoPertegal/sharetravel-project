part of 'driver_trips_bloc.dart';

@immutable
sealed class DriverTripsEvent {}

class DoDriverTripsEvent extends DriverTripsEvent {
  DoDriverTripsEvent();
}
