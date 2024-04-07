part of 'create_rating_bloc.dart';

@immutable
sealed class CreateRatingEvent {}

class DoCreateRatingEvent extends CreateRatingEvent {
  final double ratingValue;
  final String feedback;
  final String driverId;
  DoCreateRatingEvent(this.ratingValue, this.feedback, this.driverId);
}
