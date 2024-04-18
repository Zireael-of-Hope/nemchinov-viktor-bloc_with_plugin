import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter_application_1/database/repos/emoji_repo.dart';
import 'package:flutter_application_1/database/repos/tweet_repo.dart';
import 'package:flutter_application_1/database/repos/user_repo.dart';
import 'package:flutter_application_1/models/user_back_model.dart';
import 'package:flutter_application_1/objectbox.g.dart';

class TweeetrixRepository {
  late final Store _store;
  late UserRepo userRepo;
  late TweetRepo tweetRepo;
  late EmojiRepo emojiRepo;

  TweeetrixRepository._create(this._store) {
    userRepo = UserRepo(_store);
    tweetRepo = TweetRepo(_store);
    emojiRepo = EmojiRepo(_store);
  }

  static Future<TweeetrixRepository> create() async {
    final store = await openStore();

    if (Sync.isAvailable()) {
      final ipSyncServer = Platform.isAndroid ? '10.0.2.2' : '127.0.0.1';
      final syncClient = Sync.client(
        store,
        'ws://$ipSyncServer:9999',
        SyncCredentials.none(),
      );
      syncClient.connectionEvents.listen(print);
      syncClient.start();
    }
    return TweeetrixRepository._create(store);
  }

  FutureOr<void> generate100Tweets() {
    final _rnd = Random();
    final List<User> users = userRepo.box.getAll();

    for (int i = 0; i < 100; i++) {
      final tempUser = users[_rnd.nextInt(users.length)];
      tweetRepo.insertEntity(tweetRepo.createTweet(
          text: generateRandomString(100), isPublic: true, user: tempUser));
    }
  }

  String generateRandomString(int length) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final _rnd = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

  Future<void> createTestEnities() async {
    final List<String> names = <String>[
      'HanSolo',
      'AnakinSkywalker',
      'IndianaJones',
      'JackRicher',
      'RandomGuy'
    ];
    final List<String> emails = <String>[
      'hs@mail.ru',
      'as@mail.ru',
      'ij@mail.ru',
      'jr@mail.ru',
      'rg@mail.ru'
    ];

    for (int i = 0; i < names.length; i++) {
      if (await userRepo.getUserByUsername(username: names[i]) == null) {
        final randomGuy = userRepo.getEntity(userRepo.box.put(
            User(username: names[i], email: emails[i], password: '123456')));
        for (int j = 0; j < 3; j++) {
          tweetRepo.insertEntity(tweetRepo.createTweet(
              text: 'text tweet of ${names[i]} number $j',
              isPublic: true,
              user: randomGuy!));
        }
      }
    }
  }
}
