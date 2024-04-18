import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/home_page/bloc/home_page_bloc/home_bloc.dart';
import 'package:flutter_application_1/features/home_page/bloc/home_page_bloc/home_event.dart';
import 'package:flutter_application_1/features/tweet_create_page/ui/tweet_create_state_manager.dart';
import 'package:flutter_application_1/models/user_back_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TweetCreateButton extends StatelessWidget {
  const TweetCreateButton({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20,
      bottom: 20,
      child: SizedBox(
        height: 60,
        width: 60,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0))),
          ),
          onPressed: () async {
            final shouldUpdateTweets = await Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => TweetCreatePage(user: user)));
            shouldUpdateTweets != null
                ? BlocProvider.of<HomeBloc>(context)
                    .add(UpdateUserTweets(user: user))
                : {};
          },
          child: Icon(
            Icons.add_box_outlined,
            color: Colors.yellow,
          ),
        ),
      ),
    );
  }
}
