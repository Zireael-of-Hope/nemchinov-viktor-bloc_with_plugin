import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Caption extends StatelessWidget {
  const Caption({super.key, this.heightFromTop = 30, required this.text});

  final double heightFromTop;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        SizedBox(height: heightFromTop),
        Text(
          text,
          style: GoogleFonts.roboto(fontSize: 22, color: Colors.black),
        ),
      ],
    ));
  }
}
