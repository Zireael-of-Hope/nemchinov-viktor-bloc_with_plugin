abstract class LoginEvent {}

class Init extends LoginEvent {}

class ChangePasswordVisibility extends LoginEvent {}

class SubmitButtonClicked extends LoginEvent {}

class ClearEmailField extends LoginEvent {}

class RegisterButtonClicked extends LoginEvent {}

class FieldsChanged extends LoginEvent {
  String? email;
  String? password;
  FieldsChanged({this.email, this.password});
}
