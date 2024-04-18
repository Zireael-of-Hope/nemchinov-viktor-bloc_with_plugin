import 'package:flutter_application_1/models/user_back_model.dart';

abstract class TweetCreateEvent {}

class InitialEvent extends TweetCreateEvent {}

class EnableButton extends TweetCreateEvent {}

class DisableButton extends TweetCreateEvent {}

class SetPublic extends TweetCreateEvent {}

class SetPrivate extends TweetCreateEvent {}

class MakeTweet extends TweetCreateEvent {
  final String tweetText;
  final bool isPublic;
  final User user;
  MakeTweet(
      {required this.tweetText, required this.isPublic, required this.user});
}
