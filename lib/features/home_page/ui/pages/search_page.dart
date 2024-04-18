import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/home_page/bloc/IN-PROGRESS-search_bloc/search_bloc.dart';
import 'package:flutter_application_1/features/home_page/bloc/IN-PROGRESS-search_bloc/search_event.dart';
import 'package:flutter_application_1/features/home_page/bloc/IN-PROGRESS-search_bloc/search_state.dart';
import 'package:flutter_application_1/features/home_page/ui/pages/widgets/search_page_widgets/found_user_front_model.dart';
import 'package:flutter_application_1/features/home_page/ui/pages/widgets/search_page_widgets/search_persistent_header.dart';
import 'package:flutter_application_1/models/user_back_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.user});

  final User user;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final FocusNode searchFieldFocusNode = FocusNode();

  @override
  void initState() {
    searchFieldFocusNode.addListener(() {
      BlocProvider.of<SearchBloc>(context).add(SearchFieldFocusChanged());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SafeArea(
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              BlocBuilder<SearchBloc, SearchState>(
                buildWhen: (previous, current) => current is SearchFieldRebuild,
                builder: (context, state) {
                  return SliverPersistentHeader(
                      floating: true,
                      delegate: SearchPersistentHeader(
                          maxExtent: 60,
                          searchFieldFocusNode: searchFieldFocusNode,
                          searchFieldHeight: 45,
                          searchFieldWidth: 250));
                },
              ),
              BlocBuilder<SearchBloc, SearchState>(
                  buildWhen: (previous, current) => current is BuildUsers,
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case BuildUsers:
                        if ((state as BuildUsers).foundUsers.isNotEmpty) {
                          return SliverList(
                            delegate: SliverChildBuilderDelegate(
                                childCount: state.foundUsers.length,
                                (context, index) {
                              return FoundUserModel(
                                thisUser: widget.user,
                                thatUser: state.foundUsers[
                                    index], /* isFollowing: isFollowing*/
                              );
                            }),
                          );
                        } else {
                          return SliverToBoxAdapter(child: Container());
                        }
                      default:
                        return SliverToBoxAdapter(child: Container());
                    }
                  }),
            ],
          ),
        ),
      ),
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
    );
  }
}
