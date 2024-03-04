import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sharetravel_frontend/model/response/user_details_response.dart';
import 'package:sharetravel_frontend/repository/user_details/user_details_repository.dart';

part 'user_details_event.dart';
part 'user_details_state.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  final UserDetailsRepository userDetailsRepository;
  UserDetailsBloc(this.userDetailsRepository) : super(UserDetailsInitial()) {
    on<DoUserDetailsEvent>(_doUserDetails);
  }

  Future<void> _doUserDetails(
      DoUserDetailsEvent event, Emitter<UserDetailsState> emit) async {
    emit(DoUserDetailsLoading());

    try {
      final response = await userDetailsRepository.userDetails();
      emit(DoUserDetailsSuccess(response));
      return;
    } on Exception catch (e) {
      emit(DoUserDetailsError(e.toString()));
    }
  }
}
