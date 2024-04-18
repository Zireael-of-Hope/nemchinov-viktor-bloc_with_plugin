import 'package:flutter_application_1/models/tweet_back_model.dart';
import 'package:flutter_application_1/models/user_back_model.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
@Sync()
class Emoji {
  int id;
  String symbol;

  final author = ToOne<User>();
  final tweet = ToOne<Tweet>();

  Emoji({this.id = 0, required this.symbol});
}
