import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/tweetrix_repository.dart';
import 'package:flutter_application_1/features/home_page/bloc/IN-PROGRESS-search_bloc/search_bloc.dart';
import 'package:flutter_application_1/features/home_page/bloc/home_page_bloc/home_bloc.dart';
import 'package:flutter_application_1/features/home_page/bloc/home_page_bloc/home_event.dart';
import 'package:flutter_application_1/features/home_page/ui/pages/search_page.dart';
import 'package:flutter_application_1/features/home_page/ui/pages/user_page.dart';
import 'package:flutter_application_1/features/home_page/ui/pages/wall_page.dart';
import 'package:flutter_application_1/models/user_back_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext build) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        height: 60,
        backgroundColor: Colors.yellow,
        indicatorColor: Colors.black,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        onDestinationSelected: (newPageIndex) {
          BlocProvider.of<HomeBloc>(context).add(PageChanged());
          setState(() {
            currentPageIndex = newPageIndex;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: [
          NavigationDestination(
              icon: Icon(Icons.home, size: 40),
              label: '',
              selectedIcon: Icon(Icons.home, size: 40, color: Colors.yellow)),
          NavigationDestination(
            icon: Icon(Icons.person_search, size: 40),
            label: '',
            selectedIcon: Icon(
              Icons.person_search,
              size: 40,
              color: Colors.yellow,
            ),
          ),
          NavigationDestination(
            icon: Icon(Icons.person, size: 40),
            label: '',
            selectedIcon: Icon(
              Icons.person,
              size: 40,
              color: Colors.yellow,
            ),
          ),
        ],
      ),
      body: [
        WallPage(user: widget.user),
        BlocProvider(
            create: (context) => SearchBloc(
                database: RepositoryProvider.of<TweeetrixRepository>(context)),
            child: SearchPage(user: widget.user)),
        UserPage(user: widget.user),
      ][currentPageIndex],
    );
  }
}
