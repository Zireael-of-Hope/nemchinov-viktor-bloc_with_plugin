import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/home_page/bloc/home_page_bloc/home_bloc.dart';
import 'package:flutter_application_1/features/home_page/bloc/home_page_bloc/home_event.dart';
import 'package:flutter_application_1/models/tweet_back_model.dart';
import 'package:flutter_application_1/models/user_back_model.dart';

class EmojiBottomSheetGridView extends StatelessWidget {
  EmojiBottomSheetGridView(
      {super.key,
      required this.emojis,
      required this.tweet,
      required this.user,
      required this.bloc});

  final List<String> emojis;
  final Tweet tweet;
  final User user;
  final HomeBloc bloc;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 8,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: emojis.length,
        itemBuilder: (context, index) => GestureDetector(
              child: Container(
                child: Text(emojis[index], style: TextStyle(fontSize: 30)),
              ),
              onTap: () {
                bloc.add(EmojiPressed(
                    pickedEmojiSymbol: emojis[index], tweet: tweet));
                Navigator.pop(context);
              },
            ));
  }
}
