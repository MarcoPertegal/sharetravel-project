part of 'register_driver_bloc.dart';

@immutable
sealed class RegisterDriverState {}

final class RegisterDriverInitial extends RegisterDriverState {}

final class DoRegisterDriverLoading extends RegisterDriverState {}

final class DoRegisterDriverSuccess extends RegisterDriverState {
  final RegisterResponse userRegisterDriver;
  DoRegisterDriverSuccess(this.userRegisterDriver);
}

final class DoRegisterDriverError extends RegisterDriverState {
  final String errorMessage;
  DoRegisterDriverError(this.errorMessage);
}
