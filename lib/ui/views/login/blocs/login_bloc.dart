import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_exchange/dtos/notify_type.dart';
import 'package:job_exchange/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/utils/jwt_interceptor.dart';
import '../../../common/utils/message_from_exception.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository = AuthRepository();

  LoginBloc() : super(LoginInitialState()) {
    on<LoginSubmitEvent>(_onSubmit);
  }

  Future<void> _onSubmit(
      LoginSubmitEvent event, Emitter<LoginState> emit) async {

    if (event.username.isEmpty || event.password.isEmpty) {
      emit(LoginInvalid(usernameInvalid: event.username.isEmpty, passwordInvalid: event.password.isEmpty));
      return;
    }

    try {
      var future = _authRepository.loginUser(
          username: event.username,
          password: event.password);

      await future.then((response) async {
        await SharedPreferences.getInstance().then((prefs) {
          prefs.setString('refreshToken', response.data['token']);
          return JwtInterceptor()
              .refreshAccessToken(prefs, false)
              .then((value) => value != null);
        });
        emit(LoginSuccess());
      }).catchError((error) {
        String message = getMessageFromException(error);
        emit(LoginFailure(message: message, notifyType: NotifyType.error));
      });
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      emit(LoginFailure(message: message, notifyType: NotifyType.error));
    }
  }
}