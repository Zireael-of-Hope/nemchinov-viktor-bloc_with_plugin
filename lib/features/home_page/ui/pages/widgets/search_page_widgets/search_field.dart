import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/home_page/bloc/IN-PROGRESS-search_bloc/search_bloc.dart';
import 'package:flutter_application_1/features/home_page/bloc/IN-PROGRESS-search_bloc/search_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchField extends StatelessWidget {
  SearchField(
      {super.key,
      required this.focusNode,
      required this.height,
      required this.width});

  final FocusNode focusNode;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 15),
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: focusNode.hasFocus ? Colors.yellow : Colors.black45,
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Search Tweetrix',
            hintStyle: GoogleFonts.roboto(
                fontSize: 21, color: Colors.yellow.withOpacity(0.80)),
          ),
          focusNode: focusNode,
          style: GoogleFonts.roboto(
              fontSize: 21,
              color: focusNode.hasFocus ? Colors.black : Colors.yellow),
          onChanged: (text) => BlocProvider.of<SearchBloc>(context)
              .add(MakeSearch(profileName: text)),
        ));
  }
}
