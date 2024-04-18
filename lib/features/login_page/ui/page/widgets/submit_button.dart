import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/login_page/bloc/login_bloc.dart';
import 'package:flutter_application_1/features/login_page/bloc/login_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SubmitButton extends StatelessWidget {
  SubmitButton(
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
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isEnabled
            ? () => {
                  FocusScope.of(context).requestFocus(FocusNode()),
                  BlocProvider.of<LoginBloc>(context).add(SubmitButtonClicked())
                }
            : null,
        child: Text(
          'Submit',
          style: GoogleFonts.roboto(
              fontSize: 24, color: Colors.yellow, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
