abstract class RegisterState {}

abstract class RegisterListenState extends RegisterState {}

abstract class RegisterBuildState extends RegisterState {}

class CancelState extends RegisterListenState {}

class LoadingState extends RegisterFormState {
  LoadingState()
      : super(
            isFieldsEnabled: false,
            isButtonEnabled: false,
            isPasswordVisible: false,
            usernameKey: '2',
            emailKey: '1',
            passwordKey: '0',
            usernameValue: '',
            emailValue: '',
            passwordValue: '');
}

class ClearFieldsState extends RegisterFormState {
  ClearFieldsState()
      : super(
            isFieldsEnabled: true,
            isButtonEnabled: false,
            isPasswordVisible: false,
            usernameKey: '2',
            emailKey: '1',
            passwordKey: '0',
            usernameValue: '',
            emailValue: '',
            passwordValue: '');
}

class RegisterFormState extends RegisterBuildState {
  final bool isFieldsEnabled;
  final bool isButtonEnabled;
  final bool isPasswordVisible;
  final String usernameValue;
  final String usernameKey;
  final String emailKey;
  final String passwordKey;
  final String emailValue;
  final String passwordValue;
  SubmitResult? submitResult;

  RegisterFormState(
      {required this.isFieldsEnabled,
      required this.isButtonEnabled,
      required this.isPasswordVisible,
      required this.usernameKey,
      required this.emailKey,
      required this.passwordKey,
      required this.usernameValue,
      required this.emailValue,
      required this.passwordValue,
      this.submitResult});
}

class InitialState extends RegisterFormState {
  InitialState()
      : super(
            isFieldsEnabled: true,
            isButtonEnabled: false,
            isPasswordVisible: false,
            usernameKey: 'initial username key',
            emailKey: 'initial email key',
            passwordKey: 'initial password key',
            usernameValue: '',
            emailValue: '',
            passwordValue: '');
}

class SubmitResult {
  final String result;
  final bool isSuccess;
  const SubmitResult({required this.result, required this.isSuccess});
}
