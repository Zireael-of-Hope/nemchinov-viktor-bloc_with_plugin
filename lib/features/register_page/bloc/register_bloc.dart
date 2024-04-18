import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/database/tweetrix_repository.dart';
import 'package:flutter_application_1/features/register_page/bloc/register_event.dart';
import 'package:flutter_application_1/features/register_page/bloc/register_state.dart';
import 'package:flutter_application_1/models/user_back_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final emailRegExp = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
final usernameRegExp = RegExp(r'^[a-zA-Z0-9_]{1,15}$');

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  late TweeetrixRepository database;
  late String username;
  late String email;
  late String password;
  late bool isPasswordVisible;
  late bool isButtonEnabled;
  SubmitResult? submitResultPack;
  late String usernameKey;
  late String emailKey;
  late String passwordKey;

  RegisterBloc({required this.database}) : super(InitialState()) {
    email = '';
    password = '';
    isPasswordVisible = false;
    isButtonEnabled = false;
    usernameKey = 'initial username key';
    emailKey = 'initial email key';
    passwordKey = 'initial password key';
    on<Init>(initialEventToState);
    on<RegisterButtonClicked>(registerButtonClickedEventToState);
    on<CancelButtonClicked>(cancelButtonClickedEventToState);
    on<FieldsChanged>(fieldsChangedEventToState);
    on<ChangePasswordVisibility>(changePasswordVisibilityEventToState);
    on<ClearEmailField>(clearEmailFieldEvent);
    on<ClearUsernameField>(clearUsernameFieldEvent);
  }

  FutureOr<void> fieldsChangedEventToState(
      FieldsChanged event, Emitter<RegisterState> emit) {
    event.username != null ? username = event.username! : username = username;
    event.email != null ? email = event.email! : email = email;
    event.password != null ? password = event.password! : password = password;

    if (usernameRegExp.hasMatch(username) &&
        emailRegExp.hasMatch(email) &&
        password.length >= 6) {
      isButtonEnabled = true;
      emit(RegisterFormState(
        isFieldsEnabled: true,
        isButtonEnabled: isButtonEnabled,
        isPasswordVisible: isPasswordVisible,
        usernameKey: usernameKey,
        emailKey: emailKey,
        passwordKey: passwordKey,
        usernameValue: username,
        emailValue: email,
        passwordValue: password,
      ));
    } else {
      isButtonEnabled = false;
      emit(RegisterFormState(
        isFieldsEnabled: true,
        isButtonEnabled: isButtonEnabled,
        isPasswordVisible: isPasswordVisible,
        usernameKey: usernameKey,
        emailKey: emailKey,
        passwordKey: passwordKey,
        usernameValue: username,
        emailValue: email,
        passwordValue: password,
      ));
    }
  }

  FutureOr<void> registerButtonClickedEventToState(
      RegisterButtonClicked event, Emitter<RegisterState> emit) async {
    emit(LoadingState());
    try {
      if (await database.userRepo.getUserByEmail(email: email) != null) {
        isButtonEnabled = false;
        emit(RegisterFormState(
            isFieldsEnabled: true,
            isButtonEnabled: isButtonEnabled,
            isPasswordVisible: isPasswordVisible,
            usernameKey: usernameKey,
            emailKey: emailKey,
            passwordKey: passwordKey,
            usernameValue: username,
            emailValue: email,
            passwordValue: password,
            submitResult: SubmitResult(
                result: 'User with such email already exists.',
                isSuccess: false)));
      }
      if (await database.userRepo.getUserByEmail(email: email) == null &&
          await database.userRepo.getUserByUsername(username: username) !=
              null) {
        isButtonEnabled = false;
        emit(RegisterFormState(
            isFieldsEnabled: true,
            isButtonEnabled: isButtonEnabled,
            isPasswordVisible: isPasswordVisible,
            usernameKey: usernameKey,
            emailKey: emailKey,
            passwordKey: passwordKey,
            usernameValue: username,
            emailValue: email,
            passwordValue: password,
            submitResult: SubmitResult(
                result: 'User with such username already exists.',
                isSuccess: false)));
      }
      if (await database.userRepo.getUserByEmail(email: email) == null &&
          await database.userRepo.getUserByUsername(username: username) ==
              null) {
        isButtonEnabled = false;
        database.userRepo.insertEntity(
            User(username: username, email: email, password: password));
        username = '';
        email = '';
        password = '';
        usernameKey = DateTime.now().toString();
        emailKey = DateTime.now().add(Duration(days: 365)).toString();
        passwordKey = DateTime.now().add(Duration(days: 730)).toString();
        emit(RegisterFormState(
          isFieldsEnabled: true,
          isButtonEnabled: isButtonEnabled,
          isPasswordVisible: isPasswordVisible,
          usernameKey: usernameKey,
          emailKey: emailKey,
          passwordKey: passwordKey,
          usernameValue: username,
          emailValue: email,
          passwordValue: password,
          submitResult:
              SubmitResult(result: 'Welcome to Tweetrix!', isSuccess: true),
        ));
        await Future.delayed(Duration(seconds: 2));
        emit(CancelState());
      }
    } catch (e) {
      isButtonEnabled = false;
      emit(RegisterFormState(
        isFieldsEnabled: true,
        isButtonEnabled: isButtonEnabled,
        isPasswordVisible: isPasswordVisible,
        usernameKey: usernameKey,
        emailKey: emailKey,
        passwordKey: passwordKey,
        usernameValue: username,
        emailValue: email,
        passwordValue: password,
        submitResult: SubmitResult(
            result: 'Server is temporarily unavailable..', isSuccess: false),
      ));
    }
  }

  FutureOr<void> cancelButtonClickedEventToState(
      CancelButtonClicked event, Emitter<RegisterState> emit) async {
    emit(LoadingState());
    await Future.delayed(Duration(seconds: 1));
    emit(CancelState());
  }

  FutureOr<void> initialEventToState(
      Init event, Emitter<RegisterState> emit) async {
    isPasswordVisible = false;
    username = '';
    email = '';
    password = '';
    emit(InitialState());
  }

  FutureOr<void> changePasswordVisibilityEventToState(
      ChangePasswordVisibility event, Emitter<RegisterState> emit) {
    isPasswordVisible = !isPasswordVisible;
    emit(RegisterFormState(
      isFieldsEnabled: true,
      isButtonEnabled: isButtonEnabled,
      isPasswordVisible: isPasswordVisible,
      usernameKey: usernameKey,
      emailKey: emailKey,
      passwordKey: passwordKey,
      usernameValue: username,
      emailValue: email,
      passwordValue: password,
    ));
  }

  FutureOr<void> clearEmailFieldEvent(
      ClearEmailField event, Emitter<RegisterState> emit) {
    email = '';
    emailKey = DateTime.now().add(Duration(days: 365)).toString();
    emit(RegisterFormState(
      isFieldsEnabled: true,
      isButtonEnabled: isButtonEnabled,
      isPasswordVisible: isPasswordVisible,
      usernameKey: usernameKey,
      emailKey: emailKey,
      passwordKey: passwordKey,
      usernameValue: username,
      emailValue: email,
      passwordValue: password,
    ));
  }

  FutureOr<void> clearUsernameFieldEvent(
      ClearUsernameField event, Emitter<RegisterState> emit) {
    username = '';
    usernameKey = DateTime.now().toString();
    emit(RegisterFormState(
      isFieldsEnabled: true,
      isButtonEnabled: isButtonEnabled,
      isPasswordVisible: isPasswordVisible,
      usernameKey: usernameKey,
      emailKey: emailKey,
      passwordKey: passwordKey,
      usernameValue: username,
      emailValue: email,
      passwordValue: password,
    ));
  }
}
