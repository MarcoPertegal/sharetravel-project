import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sharetravel_frontend/model/dto/register_dto.dart';
import 'package:sharetravel_frontend/model/response/register_response.dart';
import 'package:sharetravel_frontend/repository/register/register_passenger/register_passenger_repository.dart';

part 'register_passenger_event.dart';
part 'register_passenger_state.dart';

class RegisterPassengerBloc
    extends Bloc<RegisterPassengerEvent, RegisterPassengerState> {
  final RegisterPassengerRepository registerPassengerRepository;
  RegisterPassengerBloc(this.registerPassengerRepository)
      : super(RegisterPassengerInitial()) {
    on<DoRegisterPassengerEvent>(_doRegisterPassenger);
  }

  void _doRegisterPassenger(DoRegisterPassengerEvent event,
      Emitter<RegisterPassengerState> emit) async {
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
          await registerPassengerRepository.registerPassenger(registerDto);
      emit(DoRegisterPassengerSuccess(response));
      return;
    } on Exception catch (e) {
      emit(DoRegisterPassengerError(e.toString()));
    }
  }
}
