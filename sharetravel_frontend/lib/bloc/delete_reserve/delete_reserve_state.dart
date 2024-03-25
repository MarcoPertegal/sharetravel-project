part of 'delete_reserve_bloc.dart';

@immutable
sealed class DeleteReserveState {}

final class DeleteReserveInitial extends DeleteReserveState {}

final class DoDeleteReserveLoading extends DeleteReserveState {}

final class DoDeleteReserveSuccess extends DeleteReserveState {
  DoDeleteReserveSuccess();
}

final class DoDeleteReserveError extends DeleteReserveState {
  final String errorMessage;
  DoDeleteReserveError(this.errorMessage);
}
