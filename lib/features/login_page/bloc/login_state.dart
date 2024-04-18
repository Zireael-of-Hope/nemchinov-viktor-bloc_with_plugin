import 'package:flutter_application_1/models/user_back_model.dart';

abstract class LoginState {}

abstract class LoginListenState extends LoginState {}

abstract class LoginBuildState extends LoginState {}

class LoadingState extends LoginFormState {
  LoadingState()
      : super(
          isFieldsEnabled: false,
          isButtonEnabled: false,
          isPasswordVisible: false,
          emailValue: '',
          passwordValue: '',
          emailKey: '',
        );
}

class GoToRegisterState extends LoginListenState {}

class GoToHomeState extends LoginListenState {
  final User user;
  GoToHomeState({required this.user});
}

class LoginFormState extends LoginBuildState {
  final bool isFieldsEnabled;
  final bool isButtonEnabled;
  final bool isPasswordVisible;
  final String emailValue;
  final String passwordValue;
  SubmitResult? submitResult;
  final String emailKey;

  LoginFormState(
      {required this.isFieldsEnabled,
      required this.isButtonEnabled,
      required this.isPasswordVisible,
      required this.emailValue,
      required this.passwordValue,
      required this.emailKey,
      this.submitResult});
}

class InitialState extends LoginFormState {
  InitialState({required String emailKey})
      : super(
          isFieldsEnabled: true,
          isButtonEnabled: false,
          isPasswordVisible: false,
          emailKey: emailKey,
          emailValue: '',
          passwordValue: '',
        );
}

class SubmitResult {
  final String result;
  final bool isSuccess;
  const SubmitResult({required this.result, required this.isSuccess});
}
