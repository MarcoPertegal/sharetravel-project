part of 'driver_ratings_bloc.dart';

@immutable
sealed class DriverRatingsEvent {}

class DoDriverRatingsEvent extends DriverRatingsEvent {
  DoDriverRatingsEvent();
}
