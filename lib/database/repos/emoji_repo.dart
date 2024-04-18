import 'package:flutter_application_1/database/repos/abstract_repo.dart';
import 'package:flutter_application_1/models/emoji_back_model.dart';
import 'package:flutter_application_1/objectbox.g.dart';

class EmojiRepo extends Repository<Emoji> {
  EmojiRepo(Store store) {
    box = Box<Emoji>(store);
  }
}
