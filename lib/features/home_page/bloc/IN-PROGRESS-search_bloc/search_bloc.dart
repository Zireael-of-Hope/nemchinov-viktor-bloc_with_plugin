import 'dart:async';

import 'package:flutter_application_1/database/tweetrix_repository.dart';
import 'package:flutter_application_1/features/home_page/bloc/IN-PROGRESS-search_bloc/search_event.dart';
import 'package:flutter_application_1/features/home_page/bloc/IN-PROGRESS-search_bloc/search_state.dart';
import 'package:flutter_application_1/models/user_back_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final TweeetrixRepository database;
  late StreamSubscription subscription;
  late int getThisManyUsers;
  List<User> foundUsers = List.empty(growable: true);

  SearchBloc({required this.database}) : super(InitialState()) {
    on<MakeSearch>(makeSearchEvent);
    on<SearchFieldFocusChanged>(searchFieldFocusChangedEvent);
    on<ResumeStreamingUser>(resumeStreamingUser);
    on<PauseStreamingUser>(pauseStreamingUser);
    on<CancelStreamingUsers>(cancelStreamingUsers);
  }

  FutureOr<void> makeSearchEvent(
      MakeSearch event, Emitter<SearchState> emit) async {
    emit(LoadingState());
  }

  FutureOr<void> searchFieldFocusChangedEvent(
      SearchFieldFocusChanged event, Emitter<SearchState> emit) {
    emit(SearchFieldRebuild());
  }

  FutureOr<void> resumeStreamingUser(
      ResumeStreamingUser event, Emitter<SearchState> emit) {
    getThisManyUsers = event.forHowManyUsers;
    subscription.resume();
  }

  FutureOr<void> pauseStreamingUser(
      PauseStreamingUser event, Emitter<SearchState> emit) {
    subscription.pause();
  }

  FutureOr<void> cancelStreamingUsers(
      CancelStreamingUsers event, Emitter<SearchState> emit) {
    subscription.cancel();
  }
}
