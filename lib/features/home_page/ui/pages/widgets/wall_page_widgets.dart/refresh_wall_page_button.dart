import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/home_page/bloc/home_page_bloc/home_bloc.dart';
import 'package:flutter_application_1/features/home_page/bloc/home_page_bloc/home_event.dart';
import 'package:flutter_application_1/models/user_back_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum PageType { forYou, following }

class RefreshWallPage extends StatelessWidget {
  RefreshWallPage({super.key, required this.user, required this.pageType});

  final User user;
  final PageType pageType;

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
          onPressed: () {
            switch (pageType) {
              case PageType.forYou:
                BlocProvider.of<HomeBloc>(context).add(UpdateForYouTweets());
                break;
              case PageType.following:
                BlocProvider.of<HomeBloc>(context).add(UpdateFollowingTweets());
                break;
            }
          },
          child: Icon(
            Icons.refresh,
            color: Colors.yellow,
          ),
        ),
      ),
    );
  }
}
