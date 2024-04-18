import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/login_page/bloc/login_bloc.dart';
import 'package:flutter_application_1/features/login_page/bloc/login_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailInput extends StatelessWidget {
  EmailInput({
    Key? key,
    required this.focusNode,
    required this.isFieldEnabled,
    required this.textValue,
  }) : super(key: key);

  final FocusNode focusNode;
  final bool isFieldEnabled;
  final String textValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: textValue,
      enabled: isFieldEnabled,
      focusNode: focusNode,
      textCapitalization: TextCapitalization.none,
      decoration: InputDecoration(
          focusColor: Colors.black,
          border: OutlineInputBorder(),
          hintText: 'login@sibirix.ru',
          labelText: 'Email',
          suffixIcon: textValue == ''
              ? Container(width: 0)
              : IconButton(
                  onPressed: () => BlocProvider.of<LoginBloc>(context)
                      .add(ClearEmailField()),
                  icon: Icon(Icons.cancel),
                )),
      onChanged: (text) =>
          BlocProvider.of<LoginBloc>(context).add(FieldsChanged(email: text)),
      keyboardType: TextInputType.emailAddress,
    );
  }
}
