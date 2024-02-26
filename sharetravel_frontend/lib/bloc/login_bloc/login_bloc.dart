import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/physics.dart';
import 'package:sharetravel_frontend/model/dto/login_dto.dart';
import 'package:sharetravel_frontend/model/response/login_response.dart';
import 'package:sharetravel_frontend/repository/auth/auth_repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  LoginBloc(this.authRepository) : super(LoginInitial()) {
    on<DoLoginEvent>(_doLogin);
  }

  void _doLogin(DoLoginEvent event, Emitter<LoginState> emit) async {
    emit(DoLoginLoading());

    try {
      final LoginDto loginDto =
          LoginDto(username: event.username, password: event.password);
      final response = await authRepository.login(loginDto);
      emit(DoLoginSuccess(response));
      return;
    } on Exception catch (e) {
      emit(DoLoginError(e.toString()));
    }
  }
}
