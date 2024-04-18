import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/home_page/bloc/home_page_bloc/home_bloc.dart';
import 'package:flutter_application_1/features/home_page/bloc/home_page_bloc/home_event.dart';
import 'package:flutter_application_1/models/emoji_back_model.dart';
import 'package:flutter_application_1/models/tweet_back_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class EmojiChip extends StatelessWidget {
  const EmojiChip(
      {super.key,
      required this.tweet,
      required this.emojiSymbol,
      required this.isPickedByUser,
      required this.emojiCount});

  final Tweet tweet;
  final String emojiSymbol;
  final bool isPickedByUser;
  final int emojiCount;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Chip(
          padding: EdgeInsets.only(left: 5),
          avatar: Container(
              child: Text(emojiSymbol, style: TextStyle(fontSize: 18))),
          labelStyle: GoogleFonts.roboto(
              fontSize: 18,
              color: isPickedByUser ? Colors.yellow : Colors.black),
          label: Text('$emojiCount'),
          backgroundColor:
              isPickedByUser ? Colors.black : Colors.orange.withOpacity(0.6)),
      onTap: () => BlocProvider.of<HomeBloc>(context)
          .add(EmojiPressed(tweet: tweet, pickedEmojiSymbol: emojiSymbol)),
    );
  }
}

int countEmojiNumber(Tweet tweet, Emoji emoji) {
  return tweet.emojis
      .where((emojiLoc) => emojiLoc.symbol == emoji.symbol)
      .toList()
      .length;
}
