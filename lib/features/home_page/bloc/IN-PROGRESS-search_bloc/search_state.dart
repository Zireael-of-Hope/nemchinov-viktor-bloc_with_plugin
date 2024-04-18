import 'package:flutter_application_1/models/user_back_model.dart';

abstract class SearchState {}

class BuildUsers extends SearchState {
  final List<User> foundUsers;
  BuildUsers({required this.foundUsers});
}

class InitialState extends SearchState {}

class LoadingState extends SearchState {}

class SearchFieldRebuild extends SearchState {}
