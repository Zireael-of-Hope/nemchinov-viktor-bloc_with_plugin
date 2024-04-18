import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/home_page/bloc/home_page_bloc/home_bloc.dart';
import 'package:flutter_application_1/features/home_page/bloc/home_page_bloc/home_event.dart';
import 'package:flutter_application_1/features/home_page/bloc/home_page_bloc/home_state.dart';
import 'package:flutter_application_1/features/home_page/ui/pages/widgets/tweet_front_model/tweet_front_model.dart';
import 'package:flutter_application_1/features/home_page/ui/pages/widgets/wall_page_widgets.dart/caption.dart';
import 'package:flutter_application_1/features/home_page/ui/pages/widgets/wall_page_widgets.dart/loading_middle_circ.dart';
import 'package:flutter_application_1/features/home_page/ui/pages/widgets/wall_page_widgets.dart/refresh_wall_page_button.dart';
import 'package:flutter_application_1/models/user_back_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class WallPage extends StatefulWidget {
  const WallPage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<WallPage> createState() => _WallPageState();
}

class _WallPageState extends State<WallPage> {
  ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _scrollPosition = _scrollController.offset;
    });
    BlocProvider.of<HomeBloc>(context).add(WallInitialEvent());
  }

  @override
  Widget build(BuildContext build) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverAppBar(
                    floating: true,
                    snap: true,
                    title: Center(
                      child: Text('Tweetrix',
                          style: GoogleFonts.roboto(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ),
                    bottom: TabBar(tabs: [
                      Tab(
                        child: Text(
                          'For You',
                          style: GoogleFonts.roboto(
                              fontSize: 22, color: Colors.black),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Following',
                          style: GoogleFonts.roboto(
                              fontSize: 22, color: Colors.black),
                        ),
                      ),
                    ]),
                  ),
                  BlocBuilder<HomeBloc, HomeState>(
                      buildWhen: (previous, current) =>
                          current is UpdatedWallTweetsState,
                      builder: (context, state) {
                        switch (state.runtimeType) {
                          case UpdatedForYouTweetsState:
                            _scrollController.jumpTo(_scrollPosition);
                            if ((state as UpdatedForYouTweetsState)
                                .tweets
                                .isNotEmpty) {
                              return SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  childCount: state.tweets.length,
                                  (context, index) {
                                    return TweetFrontModel(
                                        author:
                                            state.tweets[index].author.target!,
                                        tweet: state.tweets[index],
                                        user: widget.user);
                                  },
                                ),
                              );
                            } else {
                              return SliverToBoxAdapter(
                                  child: Caption(
                                heightFromTop: 100,
                                text: 'No tweets here yet',
                              ));
                            }
                          case InitialState:
                          case LoadingWallState:
                            return SliverToBoxAdapter(
                                child: MiddleCircularLoading());
                          default:
                            throw Exception(
                                'Wrong state type has been returned from HomeBloc to WallBuilder: ${state.runtimeType}');
                        }
                      }),
                ],
              ),
              //later
              //button has to has logic to recognise which page it is on
              RefreshWallPage(user: widget.user, pageType: PageType.forYou),
            ],
          ),
        ),
      ),
    );
  }
}
