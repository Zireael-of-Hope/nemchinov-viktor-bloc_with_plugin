import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/tweetrix_repository.dart';
import 'package:flutter_application_1/features/tweet_create_page/bloc/tweet_create_bloc.dart';
import 'package:flutter_application_1/features/tweet_create_page/bloc/tweet_create_state.dart';
import 'package:flutter_application_1/features/tweet_create_page/ui/page/tweet_create_page.dart';
import 'package:flutter_application_1/models/user_back_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TweetCreatePage extends StatefulWidget {
  TweetCreatePage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<TweetCreatePage> createState() => _TweetCreatePageState();
}

class _TweetCreatePageState extends State<TweetCreatePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TweetCreateBloc>(
      create: (context) => TweetCreateBloc(
          database: RepositoryProvider.of<TweeetrixRepository>(context)),
      child: BlocConsumer<TweetCreateBloc, TweetCreateState>(
          listenWhen: (previous, current) => current is TweetCreateListenState,
          buildWhen: (previous, current) => current is TweetCreateBuildState,
          builder: (context, state) {
            switch (state.runtimeType) {
              case LoadingState:
                return AbsorbPointer(
                  absorbing: true,
                  child: SafeArea(
                    child: Stack(
                      children: [
                        TweetCreatePageWidgets(
                            state: state as TweetCreatePageState,
                            user: widget.user),
                        LinearProgressIndicator(),
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: Colors.yellow.withOpacity(0.3),
                        ),
                      ],
                    ),
                  ),
                );
              case TweetCreatePageState:
                return TweetCreatePageWidgets(
                    state: state as TweetCreatePageState, user: widget.user);
              case InitialState:
                return TweetCreatePageWidgets(
                    state: state as InitialState, user: widget.user);
              default:
                throw Exception(
                    'Wrong state type has been returned from TweetCreateBloc: ${state.runtimeType}');
            }
          },
          listener: (context, state) {
            switch (state.runtimeType) {
              case MakeTweetState:
                Navigator.of(context).pop('update tweets');
                break;
            }
          }),
    );
  }
}
