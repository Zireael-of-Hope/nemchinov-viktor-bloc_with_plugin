class RegisterEvent {}

class Init extends RegisterEvent {}

class ChangePasswordVisibility extends RegisterEvent {}

class RegisterButtonClicked extends RegisterEvent {}

class CancelButtonClicked extends RegisterEvent {}

class ClearEmailField extends RegisterEvent {}

class ClearUsernameField extends RegisterEvent {}

class FieldsChanged extends RegisterEvent {
  String? username;
  String? email;
  String? password;
  FieldsChanged({this.username, this.email, this.password});
}
