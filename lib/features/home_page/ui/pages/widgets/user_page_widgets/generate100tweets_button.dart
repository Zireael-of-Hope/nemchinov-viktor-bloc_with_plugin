import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/tweetrix_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Generate100TweetsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 100,
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
          onPressed: () => RepositoryProvider.of<TweeetrixRepository>(context)
              .generate100Tweets(),
          child: Icon(
            Icons.error_outline,
            color: Colors.yellow,
          ),
        ),
      ),
    );
  }
}
