abstract class TweetCreateState {}

abstract class TweetCreateListenState extends TweetCreateState {}

abstract class TweetCreateBuildState extends TweetCreateState {}

class LoadingState extends TweetCreatePageState {
  final bool isPublic;
  LoadingState({required this.isPublic})
      : super(tweetButtonEnabled: false, isPublic: isPublic);
}

class InitialState extends TweetCreatePageState {
  InitialState() : super(tweetButtonEnabled: false, isPublic: true);
}

class MakeTweetState extends TweetCreateListenState {
  final int newTweetID;
  MakeTweetState({required this.newTweetID});
}

class TweetCreatePageState extends TweetCreateBuildState {
  final bool tweetButtonEnabled;
  final bool isPublic;
  TweetCreatePageState(
      {required this.tweetButtonEnabled, required this.isPublic});
}
