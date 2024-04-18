import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/register_page/bloc/register_bloc.dart';
import 'package:flutter_application_1/features/register_page/bloc/register_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsernameInput extends StatelessWidget {
  UsernameInput(
      {Key? key,
      required this.focusNode,
      required this.isFieldEnabled,
      required this.textValue})
      : super(key: key);

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
          border: OutlineInputBorder(),
          hintText: 'UserName13',
          labelText: 'Username',
          suffixIcon: textValue == ''
              ? Container(width: 0)
              : IconButton(
                  onPressed: () => BlocProvider.of<RegisterBloc>(context)
                      .add(ClearUsernameField()),
                  icon: Icon(Icons.cancel),
                )),
      onChanged: (text) => BlocProvider.of<RegisterBloc>(context)
          .add(FieldsChanged(username: text)),
    );
  }
}
