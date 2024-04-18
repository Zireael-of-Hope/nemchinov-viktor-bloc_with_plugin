import 'package:flutter_application_1/models/emoji_back_model.dart';
import 'package:flutter_application_1/models/user_back_model.dart';
import 'package:objectbox/objectbox.dart';

enum AccessModifier { unknown, public, private }

@Entity()
@Sync()
class Tweet {
  @Id()
  int id;
  String text;
  DateTime timePosted = DateTime.now();
  int accessModifierInt;

  @Backlink('tweet')
  final emojis = ToMany<Emoji>();
  final author = ToOne<User>();

  Tweet({this.id = 0, required this.text, this.accessModifierInt = 0});

  @Transient()
  AccessModifier get accessModifier {
    switch (accessModifierInt) {
      case 0:
        return AccessModifier.unknown;
      case 1:
        return AccessModifier.public;
      case 2:
        return AccessModifier.private;
      default:
        return AccessModifier.unknown;
    }
  }

  @Transient()
  set accessModifier(AccessModifier accessModifier) {
    switch (accessModifier) {
      case AccessModifier.unknown:
        accessModifierInt = 0;
        break;
      case AccessModifier.public:
        accessModifierInt = 1;
        break;
      case AccessModifier.private:
        accessModifierInt = 2;
        break;
    }
  }
}
