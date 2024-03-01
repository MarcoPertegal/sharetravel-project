import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharetravel_frontend/model/dto/register_dto.dart';
import 'package:sharetravel_frontend/model/response/register_response..dart';
import 'package:sharetravel_frontend/repository/register/register_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterRepository registerRepository;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  RegisterBloc(this.registerRepository) : super(RegisterInitial()) {
    on<DoRegisterEvent>(_doRegister);
  }

  void _doRegister(DoRegisterEvent event, Emitter<RegisterState> emit) async {
    try {
      final RegisterDto registerDto = RegisterDto(
          username: event.username,
          password: event.password,
          fullName: event.fullName,
          email: event.email,
          phoneNumber: event.phoneNumber,
          personalDescription: event.personalDescription,
          avatar: event.avatar);
      final response = await registerRepository.register(registerDto);
      emit(DoRegisterSuccess(response));
      return;
    } on Exception catch (e) {
      emit(DoRegisterError(e.toString()));
    }
  }
}
