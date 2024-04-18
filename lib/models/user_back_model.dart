import 'dart:typed_data';
import 'package:flutter_application_1/models/emoji_back_model.dart';
import 'package:flutter_application_1/models/tweet_back_model.dart';
import 'package:objectbox/objectbox.dart';

enum Gender { not_mentioned, female, male }

@Entity()
@Sync()
class User {
  @Id()
  int id;
  String username;
  String email;
  String password;
  String? profileName;
  String? profileDescription;
  String? occupation;
  String? location;
  Uint8List? profileAppBarImage;
  Uint8List? profileImage;
  int genderInt;
  int? age;
  String? linkToWebsite;
  DateTime? birthDate;
  DateTime joinDate = DateTime.now();

  String get displayName => profileName == null ? username : profileName!;
  set displayName(String newName) => profileName = newName;

  @Backlink()
  final emojis = ToMany<Emoji>();

  @Backlink()
  final posts = ToMany<Tweet>();

  final followers = ToMany<User>();

  final following = ToMany<User>();

  User(
      {this.id = 0,
      required this.username,
      required this.email,
      required this.password,
      this.profileName,
      this.profileDescription,
      this.location,
      this.profileAppBarImage,
      this.profileImage,
      this.genderInt = 0,
      this.age,
      this.linkToWebsite,
      this.birthDate});

  @Transient()
  Gender get gender {
    switch (genderInt) {
      case 0:
        return Gender.female;
      case 1:
        return Gender.male;
      default:
        return Gender.not_mentioned;
    }
  }

  @Transient()
  set gender(Gender gender) {
    switch (gender) {
      case Gender.female:
        genderInt = 0;
        break;
      case Gender.male:
        genderInt = 1;
        break;
      case Gender.not_mentioned:
        genderInt = 2;
        break;
    }
  }

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User && runtimeType == other.runtimeType && id == other.id;
}
