import 'package:flutter_application_1/models/tweet_back_model.dart';
import 'package:flutter_application_1/models/user_back_model.dart';

abstract class HomeState {}

abstract class UserPageState extends HomeState {}

class InitialState extends HomeState {}

abstract class WallState extends HomeState {}

abstract class UpdatedWallTweetsState extends HomeState {}

class LoadingWallState extends UpdatedWallTweetsState {}

class LoadingUserState extends UpdatedUserInfoState {}

class LoadingUserTweetsState extends UpdatedUserTweetsState {
  LoadingUserTweetsState() : super(tweets: List.empty());
}

class UpdatedForYouTweetsState extends UpdatedWallTweetsState {
  List<Tweet> tweets;
  UpdatedForYouTweetsState({required this.tweets});
}

class UpdatedFollowingTweetsState extends UpdatedWallTweetsState {
  List<Tweet> tweets;
  UpdatedFollowingTweetsState({required this.tweets});
}

class UpdatedUserInfoState extends UserPageState {
  final User? user;
  UpdatedUserInfoState({this.user});
}

class UpdatedUserTweetsState extends UserPageState {
  final List<Tweet> tweets;
  UpdatedUserTweetsState({required this.tweets});
}
