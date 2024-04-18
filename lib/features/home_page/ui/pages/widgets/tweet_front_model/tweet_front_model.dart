import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/home_page/ui/pages/widgets/tweet_front_model/emojis_list_tweet_front_model.dart';
import 'package:flutter_application_1/features/home_page/ui/pages/widgets/wall_page_widgets.dart/emoji_modal_sheet.dart';
import 'package:flutter_application_1/functions/time_difference_counter.dart';
import 'package:flutter_application_1/models/tweet_back_model.dart';
import 'package:flutter_application_1/models/user_back_model.dart';
import 'package:google_fonts/google_fonts.dart';

class TweetFrontModel extends StatelessWidget {
  TweetFrontModel(
      {super.key,
      required this.author,
      required this.tweet,
      required this.user});

  final User author;
  final Tweet tweet;
  final User user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            color: Colors.red.withOpacity(0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 25,
                    child: CircleAvatar(
                      backgroundImage: author.profileImage != null
                          ? MemoryImage(author.profileImage!)
                          : null,
                      radius: 25,
                      child: Center(
                        child: Text(
                          author.profileImage == null ? author.username[0] : '',
                          style: GoogleFonts.roboto(fontSize: 20),
                        ),
                      ),
                    )),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: RichText(
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: author.displayName,
                                      style: GoogleFonts.roboto(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(text: '  '),
                                    TextSpan(
                                      text: '@${author.username}',
                                      style: GoogleFonts.roboto(
                                          fontSize: 18, color: Colors.grey),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                '- ${countTimeDifference(tweet.timePosted, DateTime.now())}',
                                textAlign: TextAlign.start,
                                style: GoogleFonts.roboto(
                                    fontSize: 18, color: Colors.grey),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(tweet.text,
                            softWrap: true,
                            style: GoogleFonts.roboto(
                                fontSize: 18, color: Colors.black)),
                      ),
                      SizedBox(height: 13),
                      tweet.emojis.isNotEmpty
                          ? EmojisListTweetFrontModel(user: user, tweet: tweet)
                          : Container(height: 0),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(thickness: 1)
        ],
      ),
      onTap: () =>
          openEmojiModalSheet(context: context, tweet: tweet, user: user),
    );
  }
}
