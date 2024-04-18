import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/register_page/bloc/register_bloc.dart';
import 'package:flutter_application_1/features/register_page/bloc/register_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterButton extends StatelessWidget {
  RegisterButton(
      {Key? key,
      required this.isEnabled,
      required this.height,
      required this.width})
      : super(key: key);

  final bool isEnabled;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style:
            ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.all(0))),
        onPressed: isEnabled
            ? () {
                BlocProvider.of<RegisterBloc>(context)
                    .add(RegisterButtonClicked());
                FocusScope.of(context).requestFocus(FocusNode());
              }
            : null,
        child: Text(
          'Register',
          style: GoogleFonts.roboto(
              fontSize: 22, color: Colors.yellow, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
