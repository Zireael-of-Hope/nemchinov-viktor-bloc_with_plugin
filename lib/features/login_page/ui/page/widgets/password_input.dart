import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/login_page/bloc/login_bloc.dart';
import 'package:flutter_application_1/features/login_page/bloc/login_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordInput extends StatelessWidget {
  PasswordInput({
    Key? key,
    required this.focusNode,
    required this.isFieldEnabled,
    required this.isVisible,
    required this.textValue,
  }) : super(key: key);

  final FocusNode focusNode;
  final bool isFieldEnabled;
  final bool isVisible;
  final String textValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: textValue,
      enabled: isFieldEnabled,
      focusNode: focusNode,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Password',
        suffixIcon: IconButton(
          icon: isVisible ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
          onPressed: () => BlocProvider.of<LoginBloc>(context)
              .add(ChangePasswordVisibility()),
        ),
      ),
      obscureText: !isVisible,
      onChanged: (text) => BlocProvider.of<LoginBloc>(context)
          .add(FieldsChanged(password: text)),
    );
  }
}
