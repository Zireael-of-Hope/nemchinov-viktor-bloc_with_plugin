import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/home_page/bloc/IN-PROGRESS-search_bloc/search_bloc.dart';
import 'package:flutter_application_1/features/home_page/bloc/IN-PROGRESS-search_bloc/search_event.dart';
import 'package:flutter_application_1/models/user_back_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SubscribeButton extends StatelessWidget {
  SubscribeButton(
      {super.key,
      required this.isFollowing,
      required this.thisUser,
      required this.thatUser});

  final User thisUser;
  final User thatUser;
  final bool isFollowing;
  final Color subColor = Colors.yellow;
  final Color notSubColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: isFollowing ? notSubColor : subColor,
      borderRadius: BorderRadius.circular(25),
      child: Container(
        height: 40,
        width: 120,
        decoration: BoxDecoration(
            color: Colors.yellow.withOpacity(0.3),
            border: Border.all(width: 1, color: Colors.black),
            borderRadius: BorderRadius.circular(25)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                isFollowing ? 'following' : 'follow',
                style: GoogleFonts.roboto(
                    fontSize: 22, color: isFollowing ? notSubColor : subColor),
              ),
              Icon(Icons.keyboard_arrow_down),
            ],
          ),
        ),
      ),
      onTap: () {
        isFollowing
            ? BlocProvider.of<SearchBloc>(context)
                .add(Follow(thisUser: thisUser, thatUser: thatUser))
            : BlocProvider.of<SearchBloc>(context)
                .add(Unfollow(thisUser: thisUser, thatUser: thatUser));
      },
    );
  }
}
