part of 'create_rating_bloc.dart';

@immutable
sealed class CreateRatingState {}

final class CreateRatingInitial extends CreateRatingState {}

final class DoCreateRatingLoading extends CreateRatingState {}

final class DoCreateRatingSuccess extends CreateRatingState {
  final CreateRatingResponse createRatingResponse;
  DoCreateRatingSuccess(this.createRatingResponse);
}

final class DoCreateRatingError extends CreateRatingState {
  final String errorMessage;
  DoCreateRatingError(this.errorMessage);
}
