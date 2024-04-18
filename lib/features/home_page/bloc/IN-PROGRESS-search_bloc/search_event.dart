import 'package:flutter_application_1/models/user_back_model.dart';

abstract class SearchEvent {}

class MakeSearch extends SearchEvent {
  final int initialNumberOfUsers = 20;
  final String profileName;
  MakeSearch({required this.profileName});
}

class Follow extends SearchEvent {
  final User thisUser;
  final User thatUser;
  Follow({required this.thisUser, required this.thatUser});
}

class Unfollow extends SearchEvent {
  final User thisUser;
  final User thatUser;
  Unfollow({required this.thisUser, required this.thatUser});
}

class SearchFieldFocusChanged extends SearchEvent {}

class PauseStreamingUser extends SearchEvent {}

class ResumeStreamingUser extends SearchEvent {
  final int forHowManyUsers;
  ResumeStreamingUser({required this.forHowManyUsers});
}

class CancelStreamingUsers extends SearchEvent {}
