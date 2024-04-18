import 'dart:async';
import 'package:flutter_application_1/database/repos/emoji_repo.dart';
import 'package:flutter_application_1/database/repos/tweet_repo.dart';
import 'package:flutter_application_1/database/repos/user_repo.dart';
import 'package:flutter_application_1/database/tweetrix_repository.dart';
import 'package:flutter_application_1/features/home_page/bloc/home_page_bloc/home_event.dart';
import 'package:flutter_application_1/features/home_page/bloc/home_page_bloc/home_state.dart';
import 'package:flutter_application_1/models/emoji_back_model.dart';
import 'package:flutter_application_1/models/tweet_back_model.dart';
import 'package:flutter_application_1/models/user_back_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TweeetrixRepository database;
  late TweetRepo tweetRepo;
  late EmojiRepo emojiRepo;
  late UserRepo userRepo;
  final User user;
  final List<Tweet> wallTweets = List.empty(growable: true);
  final List<Tweet> userTweets = List.empty(growable: true);
  HomeBloc({required this.database, required this.user})
      : super(InitialState()) {
    tweetRepo = database.tweetRepo;
    emojiRepo = database.emojiRepo;
    userRepo = database.userRepo;
    on<EmojiPressed>(emojiPressedEvent);
    on<UpdateForYouTweets>(updateForYouTweetsEvent);
    on<UpdateFollowingTweets>(updateFollowingTweetsEvent);
    on<UpdateUserInfo>(updateUserInfoEvent);
    on<UpdateUserTweets>(updateUserTweetsEvent);
    on<PageChanged>(pageChangedEvent);
    on<WallInitialEvent>(wallInitialEvent);
    on<UserPageInitialEvent>(userPageInitialEvent);
  }

  FutureOr<void> pageChangedEvent(event, Emitter<HomeState> emit) {
    emit(InitialState());
  }

  FutureOr<void> wallInitialEvent(
      WallInitialEvent event, Emitter<HomeState> emit) {
    add(UpdateForYouTweets());
  }

  FutureOr<void> userPageInitialEvent(
      UserPageInitialEvent event, Emitter<HomeState> emit) {
    add(UpdateUserInfo(user: user));
    add(UpdateUserTweets(user: user));
  }

  FutureOr<void> updateForYouTweetsEvent(
      UpdateForYouTweets event, Emitter<HomeState> emit) async {
    emit(LoadingWallState());
    wallTweets.clear();
    final tweetStream = tweetRepo.getTweetsInStream();
    await for (Tweet newTweet in tweetStream) {
      if (newTweet.author.target!.id != user.id) {
        wallTweets.insert(0, newTweet);
      }
    }
    emit(UpdatedForYouTweetsState(tweets: wallTweets));
  }

  FutureOr<void> updateFollowingTweetsEvent(
      UpdateFollowingTweets event, Emitter<HomeState> emit) {}

  FutureOr<void> emojiPressedEvent(
      EmojiPressed event, Emitter<HomeState> emit) async {
    bool isAddingEmoji = false;

    final alreadyPickedEmoji = event.tweet.emojis
        .where((emoji) => emoji.author.target == user)
        .toList();

    if (alreadyPickedEmoji.isNotEmpty) {
      database.emojiRepo.removeEntity(alreadyPickedEmoji.first.id);
      if (alreadyPickedEmoji.first.symbol != event.pickedEmojiSymbol) {
        isAddingEmoji = true;
      }
    } else {
      isAddingEmoji = true;
    }

    if (isAddingEmoji) {
      final newEmoji = Emoji(symbol: event.pickedEmojiSymbol);
      newEmoji.author.target = user;
      newEmoji.tweet.target = event.tweet;
      database.emojiRepo.insertEntity(newEmoji);
    }

    updateLocalTweetsFromDB(
        event.tweet.author.target == user ? userTweets : wallTweets,
        event.tweet.id);
    emit(UpdatedUserTweetsState(tweets: userTweets));
    emit(UpdatedForYouTweetsState(tweets: wallTweets));
  }

  FutureOr<void> updateUserInfoEvent(
      UpdateUserInfo event, Emitter<HomeState> emit) {
    emit(LoadingUserState());
    final User? user = userRepo.getEntity(event.user.id);
    emit(UpdatedUserInfoState(user: user));
  }

  FutureOr<void> updateUserTweetsEvent(
      UpdateUserTweets event, Emitter<HomeState> emit) async {
    emit(LoadingUserTweetsState());
    userTweets.clear();
    final tweetStream =
        tweetRepo.getAllTweetsByAuthorInStream(author: event.user);
    await for (Tweet newTweet in tweetStream) {
      userTweets.insert(0, newTweet);
    }
    emit(UpdatedUserTweetsState(tweets: userTweets));
  }

  void updateLocalTweetsFromDB(List<Tweet> tweets, int tweetID) {
    for (int i = 0; i < tweets.length; i++) {
      if (tweets[i].id == tweetID) {
        tweets[i] = database.tweetRepo.getEntity(tweetID)!;
        return;
      }
    }
  }
}
