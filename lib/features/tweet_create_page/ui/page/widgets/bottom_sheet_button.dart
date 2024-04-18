import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/tweet_create_page/bloc/tweet_create_bloc.dart';
import 'package:flutter_application_1/features/tweet_create_page/bloc/tweet_create_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomSheetButton extends StatelessWidget {
  BottomSheetButton(
      {super.key,
      required this.isPublicButton,
      required this.text,
      required this.icon,
      required this.chosen});

  final bool isPublicButton;
  final String text;
  final IconData icon;
  final bool chosen;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.yellow.withOpacity(0)),
              elevation: MaterialStateProperty.all<double>(0),
              overlayColor:
                  MaterialStateColor.resolveWith((states) => Colors.black26)),
          onPressed: () {
            isPublicButton
                ? BlocProvider.of<TweetCreateBloc>(context).add(SetPublic())
                : BlocProvider.of<TweetCreateBloc>(context).add(SetPrivate());
            Navigator.of(context).pop();
          },
          child: Row(
            children: [
              Icon(
                icon,
                size: 50,
                color: Colors.black,
              ),
              SizedBox(width: 20),
              Text(text,
                  style: GoogleFonts.roboto(fontSize: 28, color: Colors.black)),
              Spacer(),
              chosen
                  ? Icon(Icons.check_box, size: 40, color: Colors.black)
                  : Container(height: 0),
            ],
          )),
    );
  }
}
