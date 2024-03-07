part of 'create_reserve_bloc.dart';

@immutable
sealed class CreateReserveEvent {}

class DoCreateReserveEvent extends CreateReserveEvent {
  final String id;
  DoCreateReserveEvent(this.id);
}
