import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/login_page/bloc/login_state.dart';
import 'package:flutter_application_1/features/login_page/ui/page/widgets/email_input.dart';
import 'package:flutter_application_1/features/login_page/ui/page/widgets/password_input.dart';
import 'package:flutter_application_1/features/login_page/ui/page/widgets/register_text.dart';
import 'package:flutter_application_1/features/login_page/ui/page/widgets/result_text.dart';
import 'package:flutter_application_1/features/login_page/ui/page/widgets/submit_button.dart';

class LoginPageWidgets extends StatefulWidget {
  final LoginFormState widgetState;
  const LoginPageWidgets({super.key, required this.widgetState});

  @override
  State<LoginPageWidgets> createState() => _LoginPageWidgetsState();
}

class _LoginPageWidgetsState extends State<LoginPageWidgets> {
  FocusNode _emailNode = FocusNode();
  FocusNode _passwordNode = FocusNode();

  SubmitResult savedSubmitResult = SubmitResult(result: '', isSuccess: false);

  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.widgetState;
    state.submitResult != null
        ? savedSubmitResult = state.submitResult!
        : savedSubmitResult = savedSubmitResult;
    return AbsorbPointer(
      absorbing: savedSubmitResult.isSuccess,
      child: Center(
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
              height: constraints.maxHeight,
              padding: EdgeInsets.all(40),
              child: Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildAuthText(),
                  SizedBox(height: 15),
                  EmailInput(
                    key: Key(state.emailKey),
                    focusNode: _emailNode,
                    isFieldEnabled: state.isFieldsEnabled,
                    textValue: state.emailValue,
                  ),
                  SizedBox(height: 15),
                  PasswordInput(
                    focusNode: _passwordNode,
                    isFieldEnabled: state.isFieldsEnabled,
                    isVisible: state.isPasswordVisible,
                    textValue: state.passwordValue,
                  ),
                  SizedBox(height: 15),
                  SubmitButton(
                      isEnabled: state.isButtonEnabled, height: 40, width: 200),
                  SizedBox(height: 15),
                  RegisterText(),
                  SizedBox(height: 15),
                  Result(submitResult: savedSubmitResult),
                ],
              )));
        }),
      ),
    );
  }

  Widget _buildAuthText() {
    return Text('Authorization',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold));
  }
}
