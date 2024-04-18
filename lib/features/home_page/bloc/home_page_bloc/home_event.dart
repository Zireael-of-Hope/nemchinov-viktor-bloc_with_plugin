import 'package:flutter_application_1/models/tweet_back_model.dart';
import 'package:flutter_application_1/models/user_back_model.dart';

abstract class HomeEvent {}

abstract class UserPageEvent extends HomeEvent {}

class WallInitialEvent extends HomeEvent {}

class UserPageInitialEvent extends HomeEvent {}

class PageChanged extends HomeEvent {}

class EmojiPressed extends HomeEvent {
  Tweet tweet;
  final String pickedEmojiSymbol;
  EmojiPressed({required this.pickedEmojiSymbol, required this.tweet});
}

class UpdateForYouTweets extends HomeEvent {}

class UpdateFollowingTweets extends HomeEvent {}

class UpdateUserInfo extends UserPageEvent {
  final User user;
  UpdateUserInfo({required this.user});
}

class UpdateUserTweets extends UserPageEvent {
  final User user;
  UpdateUserTweets({required this.user});
}
