import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/register_page/bloc/register_state.dart';
import 'package:flutter_application_1/features/register_page/ui/page/widgets/cancel_button.dart';
import 'package:flutter_application_1/features/register_page/ui/page/widgets/email_input.dart';
import 'package:flutter_application_1/features/register_page/ui/page/widgets/password_input.dart';
import 'package:flutter_application_1/features/register_page/ui/page/widgets/register_button.dart';
import 'package:flutter_application_1/features/register_page/ui/page/widgets/result.dart';
import 'package:flutter_application_1/features/register_page/ui/page/widgets/username_input.dart';

class RegisterPageWidgets extends StatefulWidget {
  final RegisterFormState widgetState;
  const RegisterPageWidgets({Key? key, required this.widgetState})
      : super(key: key);

  @override
  State<RegisterPageWidgets> createState() => _RegisterPageWidgetsState();
}

class _RegisterPageWidgetsState extends State<RegisterPageWidgets> {
  FocusNode usernameNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();

  SubmitResult savedSubmitResult = SubmitResult(result: '', isSuccess: false);

  @override
  void initState() {
    super.initState();
  }

  @override
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildRegText(),
                SizedBox(height: 15),
                UsernameInput(
                    key: Key(state.usernameKey),
                    focusNode: usernameNode,
                    isFieldEnabled: state.isFieldsEnabled,
                    textValue: state.usernameValue),
                SizedBox(height: 15),
                EmailInput(
                    key: Key(state.emailKey),
                    focusNode: emailNode,
                    isFieldEnabled: state.isFieldsEnabled,
                    textValue: state.emailValue),
                SizedBox(height: 15),
                PasswordInput(
                  key: Key(state.passwordKey),
                    focusNode: passwordNode,
                    isFieldEnabled: state.isFieldsEnabled,
                    isVisible: state.isPasswordVisible,
                    textValue: state.passwordValue),
                SizedBox(height: 15),
                SizedBox(
                  width: 300,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CancelButton(
                          isEnabled: state.isFieldsEnabled,
                          height: 40,
                          width: 115,
                        ),
                        RegisterButton(
                            isEnabled: state.isButtonEnabled,
                            height: 40,
                            width: 115),
                      ]),
                ),
                SizedBox(height: 15),
                Result(submitResult: savedSubmitResult)
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildRegText() {
    return Text('Registration',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold));
  }
}
