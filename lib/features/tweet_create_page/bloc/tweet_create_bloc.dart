import 'dart:async';

import 'package:flutter_application_1/database/tweetrix_repository.dart';
import 'package:flutter_application_1/features/tweet_create_page/bloc/tweet_create_event.dart';
import 'package:flutter_application_1/features/tweet_create_page/bloc/tweet_create_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TweetCreateBloc extends Bloc<TweetCreateEvent, TweetCreateState> {
  final TweeetrixRepository database;
  late bool isPublic;
  late bool tweetButtonEnabledl;

  TweetCreateBloc({required this.database}) : super(InitialState()) {
    isPublic = true;
    tweetButtonEnabledl = false;
    on<InitialEvent>(initialEvent);
    on<EnableButton>(enableButtonEvent);
    on<DisableButton>(disableButtonEvent);
    on<MakeTweet>(makeTweetEvent);
    on<SetPublic>(setPublicEvent);
    on<SetPrivate>(setPrivateEvent);
  }

  FutureOr<void> initialEvent(
      InitialEvent event, Emitter<TweetCreateState> emit) {
    emit(InitialState());
  }

  FutureOr<void> enableButtonEvent(
      EnableButton event, Emitter<TweetCreateState> emit) {
    tweetButtonEnabledl = true;
    emit(TweetCreatePageState(
        tweetButtonEnabled: tweetButtonEnabledl, isPublic: isPublic));
  }

  FutureOr<void> disableButtonEvent(
      DisableButton event, Emitter<TweetCreateState> emit) {
    tweetButtonEnabledl = false;
    emit(TweetCreatePageState(
        tweetButtonEnabled: tweetButtonEnabledl, isPublic: isPublic));
  }

  FutureOr<void> makeTweetEvent(
      MakeTweet event, Emitter<TweetCreateState> emit) async {
    emit(LoadingState(isPublic: isPublic));
    final tweetId = database.tweetRepo.insertEntity(database.tweetRepo
        .createTweet(
            text: event.tweetText, isPublic: event.isPublic, user: event.user));
    emit(MakeTweetState(newTweetID: tweetId));
  }

  FutureOr<void> setPublicEvent(
      SetPublic event, Emitter<TweetCreateState> emit) {
    isPublic = true;
    emit(TweetCreatePageState(
        tweetButtonEnabled: tweetButtonEnabledl, isPublic: isPublic));
  }

  FutureOr<void> setPrivateEvent(
      SetPrivate event, Emitter<TweetCreateState> emit) {
    isPublic = false;
    emit(TweetCreatePageState(
        tweetButtonEnabled: tweetButtonEnabledl, isPublic: isPublic));
  }
}
