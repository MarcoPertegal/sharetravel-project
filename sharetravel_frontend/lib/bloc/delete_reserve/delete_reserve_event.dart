part of 'delete_reserve_bloc.dart';

@immutable
sealed class DeleteReserveEvent {}

class DoDeleteReserveEvent extends DeleteReserveEvent {
  final String id;
  DoDeleteReserveEvent(this.id);
}
