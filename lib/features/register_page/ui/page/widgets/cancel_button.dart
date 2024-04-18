import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/register_page/bloc/register_bloc.dart';
import 'package:flutter_application_1/features/register_page/bloc/register_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CancelButton extends StatelessWidget {
  CancelButton(
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
      height: 40,
      width: 115,
      child: ElevatedButton(
        style:
            ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.all(0))),
        onPressed: isEnabled
            ? () => BlocProvider.of<RegisterBloc>(context)
                .add(CancelButtonClicked())
            : null,
        child: Text(
          'Cancel',
          style: GoogleFonts.roboto(
              fontSize: 22, color: Colors.yellow, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
