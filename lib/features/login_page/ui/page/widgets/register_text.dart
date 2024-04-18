import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/login_page/bloc/login_bloc.dart';
import 'package:flutter_application_1/features/login_page/bloc/login_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterText extends StatelessWidget {
  const RegisterText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
          children: <TextSpan>[
            TextSpan(text: 'Not registered yet? '),
            TextSpan(
              text: 'Click here!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  BlocProvider.of<LoginBloc>(context)
                      .add(RegisterButtonClicked());
                  FocusScope.of(context).requestFocus(FocusNode());
                },
            )
          ]),
    );
  }
}
