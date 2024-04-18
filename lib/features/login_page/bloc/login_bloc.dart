import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/database/tweetrix_repository.dart';
import 'package:flutter_application_1/features/login_page/bloc/login_event.dart';
import 'package:flutter_application_1/features/login_page/bloc/login_state.dart';
import 'package:flutter_application_1/models/user_back_model.dart';

final emailRegExp = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  late TweeetrixRepository database;
  late String email;
  late String password;
  late bool isPasswordVisible;
  late bool isButtonEnabled;
  User? user;
  late String emailKey;

  LoginBloc({required this.database})
      : super(InitialState(emailKey: 'initial key')) {
    email = '';
    password = '';
    isPasswordVisible = false;
    isButtonEnabled = false;
    emailKey = 'initial key';
    on<Init>(initialEvent);
    on<SubmitButtonClicked>(submitButtonClickedEvent);
    on<FieldsChanged>(textFieldsChangedEvent);
    on<RegisterButtonClicked>(registerTextClickedEvent);
    on<ChangePasswordVisibility>(changePasswordVisibilityEvent);
    on<ClearEmailField>(clearEmailFieldEvent);
  }

  FutureOr<void> textFieldsChangedEvent(
      FieldsChanged event, Emitter<LoginState> emit) {
    event.email != null ? email = event.email! : email = email;
    event.password != null ? password = event.password! : password = password;

    if (emailRegExp.hasMatch(email) && password.length >= 6) {
      isButtonEnabled = true;
      emit(LoginFormState(
        isFieldsEnabled: true,
        isButtonEnabled: isButtonEnabled,
        isPasswordVisible: isPasswordVisible,
        emailValue: email,
        passwordValue: password,
        emailKey: emailKey,
      ));
    } else {
      isButtonEnabled = false;
      emit(LoginFormState(
        isFieldsEnabled: true,
        isButtonEnabled: isButtonEnabled,
        isPasswordVisible: isPasswordVisible,
        emailValue: email,
        passwordValue: password,
        emailKey: emailKey,
      ));
    }
  }

  FutureOr<void> submitButtonClickedEvent(
      SubmitButtonClicked buttonEvent, Emitter<LoginState> emit) async {
    emit(LoadingState());

    user = await database.userRepo.getUserByEmail(email: email);

    if (user != null) {
      if (user!.password != password) {
        isButtonEnabled = false;
        emit(LoginFormState(
            isFieldsEnabled: true,
            isButtonEnabled: isButtonEnabled,
            isPasswordVisible: isPasswordVisible,
            emailValue: email,
            passwordValue: password,
            emailKey: emailKey,
            submitResult:
                SubmitResult(result: 'Wrong password.', isSuccess: false)));
      } else {
        isButtonEnabled = false;
        email = '';
        password = '';
        emit(LoginFormState(
            isFieldsEnabled: true,
            isButtonEnabled: isButtonEnabled,
            isPasswordVisible: isPasswordVisible,
            emailValue: email,
            passwordValue: password,
            emailKey: emailKey,
            submitResult:
                SubmitResult(result: 'Log in success.', isSuccess: true)));
        await Future.delayed(Duration(seconds: 2));
        emit(GoToHomeState(user: user!));
      }
    } else {
      isButtonEnabled = false;
      emit(LoginFormState(
        isFieldsEnabled: true,
        isButtonEnabled: isButtonEnabled,
        isPasswordVisible: isPasswordVisible,
        emailValue: email,
        passwordValue: password,
        emailKey: emailKey,
        submitResult:
            SubmitResult(result: 'No user with such email.', isSuccess: false),
      ));
    }
  }

  FutureOr<void> initialEvent(Init event, Emitter<LoginState> emit) async {
    isPasswordVisible = false;
    email = '';
    password = '';
    emit(InitialState(emailKey: emailKey));
  }

  FutureOr<void> registerTextClickedEvent(
      RegisterButtonClicked event, Emitter<LoginState> emit) async {
    emit(LoadingState());
    await Future.delayed(Duration(seconds: 1));
    emit(GoToRegisterState());
    emit(InitialState(emailKey: emailKey));
  }

  FutureOr<void> changePasswordVisibilityEvent(
      ChangePasswordVisibility event, Emitter<LoginState> emit) {
    isPasswordVisible = !isPasswordVisible;
    emit(LoginFormState(
      isFieldsEnabled: true,
      isButtonEnabled: isButtonEnabled,
      isPasswordVisible: isPasswordVisible,
      emailValue: email,
      passwordValue: password,
      emailKey: emailKey,
    ));
  }

  FutureOr<void> clearEmailFieldEvent(
      ClearEmailField event, Emitter<LoginState> emit) {
    email = '';
    emailKey = DateTime.now().toString();
    emit(LoginFormState(
      isFieldsEnabled: true,
      isButtonEnabled: isButtonEnabled,
      isPasswordVisible: isPasswordVisible,
      emailValue: email,
      passwordValue: password,
      emailKey: emailKey,
    ));
  }
}
