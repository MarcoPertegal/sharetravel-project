part of 'delete_trip_bloc.dart';

@immutable
sealed class DeleteTripEvent {}

class DoDeleteTripEvent extends DeleteTripEvent {
  final String id;
  DoDeleteTripEvent(this.id);
}
