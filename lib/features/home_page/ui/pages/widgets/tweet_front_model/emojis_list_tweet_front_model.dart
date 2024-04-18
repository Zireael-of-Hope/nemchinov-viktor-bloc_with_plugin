import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/home_page/ui/pages/widgets/tweet_front_model/emoji_chip.dart';
import 'package:flutter_application_1/models/emoji_back_model.dart';
import 'package:flutter_application_1/models/tweet_back_model.dart';
import 'package:flutter_application_1/models/user_back_model.dart';

class EmojisListTweetFrontModel extends StatelessWidget {
  EmojisListTweetFrontModel(
      {super.key, required this.user, required this.tweet});

  final User user;
  final Tweet tweet;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      children: groupEmojiByType(tweet.emojis)
          .map((emojiList) => EmojiChip(
              tweet: tweet,
              emojiSymbol: emojiList[0].symbol,
              isPickedByUser: defineIfPickedByUser(emojiList, user),
              emojiCount: emojiList.length))
          .toList(),
    );
  }
}

bool defineIfPickedByUser(List<Emoji> emojiList, User user) {
  if (emojiList
      .where((emoji) => emoji.author.target == user)
      .toList()
      .isNotEmpty) {
    return true;
  } else {
    return false;
  }
}

List<List<Emoji>> groupEmojiByType(List<Emoji> emojiList) {
  final List<String> alreadyGroupedEmoji = List.empty(growable: true);
  final List<List<Emoji>> groupedEmojis = List.empty(growable: true);

  for (int i = 0; i < emojiList.length; i++) {
    if (!alreadyGroupedEmoji.contains(emojiList[i].symbol)) {
      final String groupingType = emojiList[i].symbol;
      final List<Emoji> newEmojiGroup = List.empty(growable: true);
      for (int j = i; j < emojiList.length; j++) {
        if (emojiList[j].symbol == groupingType) {
          newEmojiGroup.add(emojiList[j]);
        }
      }
      alreadyGroupedEmoji.add(groupingType);
      groupedEmojis.add(newEmojiGroup);
    }
  }

  return groupedEmojis;
}
