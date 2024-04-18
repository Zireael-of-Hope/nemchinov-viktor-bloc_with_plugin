import 'dart:async';
import 'package:flutter_application_1/database/repos/abstract_repo.dart';
import 'package:flutter_application_1/models/tweet_back_model.dart';
import 'package:flutter_application_1/models/user_back_model.dart';
import 'package:flutter_application_1/objectbox.g.dart';

class TweetRepo extends Repository<Tweet> {
  TweetRepo(Store store) {
    box = Box<Tweet>(store);
  }

  Stream<Tweet> getAllTweetsByAuthorInStream({required User author}) async* {
    final Query<Tweet> query =
        box.query(Tweet_.author.equals(author.id)).build();
    final tweetStream = query.stream();

    await for (var tweet in tweetStream) {
      yield tweet;
    }

    query.close();
  }

  Stream<Tweet> getTweetsInStream() async* {
    final Query<Tweet> query = box.query().build();
    final tweetStream = query.stream();

    await for (var tweet in tweetStream) {
      yield tweet;
    }

    query.close();
  }

  Tweet createTweet(
      {required String text, required bool isPublic, required User user}) {
    final Tweet newTweet = Tweet(text: text);
    newTweet.accessModifier =
        isPublic ? AccessModifier.public : AccessModifier.private;
    newTweet.author.target = user;
    return newTweet;
  }
}
