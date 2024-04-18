import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/home_page/bloc/home_page_bloc/home_bloc.dart';
import 'package:flutter_application_1/features/home_page/bloc/home_page_bloc/home_event.dart';
import 'package:flutter_application_1/features/home_page/bloc/home_page_bloc/home_state.dart';
import 'package:flutter_application_1/features/home_page/ui/pages/widgets/tweet_front_model/tweet_front_model.dart';
import 'package:flutter_application_1/features/home_page/ui/pages/widgets/user_page_widgets/generate100tweets_button.dart';
import 'package:flutter_application_1/features/home_page/ui/pages/widgets/user_page_widgets/tweet_create_button.dart';
import 'package:flutter_application_1/features/home_page/ui/pages/widgets/user_page_widgets/user_info_head_widget.dart';
import 'package:flutter_application_1/features/home_page/ui/pages/widgets/user_page_widgets/user_persistent_header.dart';
import 'package:flutter_application_1/models/user_back_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class UserPage extends StatefulWidget {
  UserPage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  int currentPageIndex = 0;
  final ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _scrollPosition = _scrollController.offset;
    });
    BlocProvider.of<HomeBloc>(context).add(UserPageInitialEvent());
  }

  @override
  Widget build(BuildContext build) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
              slivers: <Widget>[
                SliverPersistentHeader(
                    pinned: true,
                    delegate: UserPersistentHeaderDelegate(
                        minExtent: 60,
                        maxExtent: 140,
                        username: widget.user.username,
                        profileImage: widget.user.profileImage)),
                SliverToBoxAdapter(
                  child: BlocBuilder<HomeBloc, HomeState>(
                    buildWhen: (previous, current) =>
                        current is UpdatedUserInfoState,
                    builder: (context, state) {
                      switch (state.runtimeType) {
                        case UpdatedUserInfoState:
                          return UserInfoHeadWidget(user: widget.user);
                        case InitialState:
                        case LoadingUserState:
                          return Stack(
                            children: [
                              Positioned(
                                  left:
                                      MediaQuery.of(context).size.width * 0.45,
                                  top: 80,
                                  child: CircularProgressIndicator()),
                              SizedBox(height: 200)
                            ],
                          );
                        default:
                          print(
                              'Wrong state type has been returned from HomeBloc to UserInfoBuilder: ${state.runtimeType}');
                          BlocProvider.of<HomeBloc>(context)
                              .add(UserPageInitialEvent());
                          return LinearProgressIndicator();
                      }
                    },
                  ),
                ),
                BlocBuilder<HomeBloc, HomeState>(
                  buildWhen: (previous, current) =>
                      current is UpdatedUserTweetsState,
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case UpdatedUserTweetsState:
                        if ((state as UpdatedUserTweetsState)
                            .tweets
                            .isNotEmpty) {
                          _scrollController.jumpTo(_scrollPosition);
                          return SliverList(
                            delegate: SliverChildBuilderDelegate(
                              childCount: state.tweets.length,
                              (context, index) {
                                return TweetFrontModel(
                                    author: widget.user,
                                    user: widget.user,
                                    tweet: state.tweets[index]);
                              },
                            ),
                          );
                        } else {
                          return SliverToBoxAdapter(
                            child: Center(
                                child: Text(
                              'No tweets here yet',
                              style: GoogleFonts.roboto(
                                  fontSize: 22, color: Colors.black),
                            )),
                          );
                        }
                      case InitialState:
                      case LoadingUserTweetsState:
                        return SliverToBoxAdapter(
                          child: Stack(
                            children: [
                              LinearProgressIndicator(),
                              SizedBox(height: 200)
                            ],
                          ),
                        );
                      default:
                        throw Exception(
                            'Wrong state type has been returned from HomeBloc to UserPageBuilder: ${state.runtimeType}');
                    }
                  },
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                )
              ],
            ),
            Generate100TweetsButton(),
            TweetCreateButton(user: widget.user),
          ],
        ),
      ),
    );
  }
}
