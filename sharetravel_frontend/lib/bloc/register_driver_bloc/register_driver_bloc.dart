import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sharetravel_frontend/model/dto/register_dto.dart';
import 'package:sharetravel_frontend/model/response/register_response.dart';
import 'package:sharetravel_frontend/repository/register/register_driver/register_driver_repository.dart';

part 'register_driver_event.dart';
part 'register_driver_state.dart';

class RegisterDriverBloc
    extends Bloc<RegisterDriverEvent, RegisterDriverState> {
  final RegisterDriverRepository registerDriverRepository;
  RegisterDriverBloc(this.registerDriverRepository)
      : super(RegisterDriverInitial()) {
    on<DoRegisterDriverEvent>(_doRegisterDriver);
  }

  void _doRegisterDriver(
      DoRegisterDriverEvent event, Emitter<RegisterDriverState> emit) async {
    try {
      final RegisterDto registerDto = RegisterDto(
          username: event.username,
          password: event.password,
          fullName: event.fullName,
          email: event.email,
          phoneNumber: event.phoneNumber,
          personalDescription: event.personalDescription,
          avatar: event.avatar);
      final response =
          await registerDriverRepository.registerDriver(registerDto);
      emit(DoRegisterDriverSuccess(response));
      return;
    } on Exception catch (e) {
      emit(DoRegisterDriverError(e.toString()));
    }
  }
}
