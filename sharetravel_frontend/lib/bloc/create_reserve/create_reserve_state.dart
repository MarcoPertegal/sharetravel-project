part of 'create_reserve_bloc.dart';

@immutable
sealed class CreateReserveState {}

final class CreateReserveInitial extends CreateReserveState {}

final class DoCreateReserveLoading extends CreateReserveState {}

final class DoCreateReserveSuccess extends CreateReserveState {
  final CreateReserveResponse createReserveResponse;
  DoCreateReserveSuccess(this.createReserveResponse);
}

final class DoCreateReserveError extends CreateReserveState {
  final String errorMessage;
  DoCreateReserveError(this.errorMessage);
}
