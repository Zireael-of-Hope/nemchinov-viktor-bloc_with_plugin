// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/tweetrix_repository.dart';
import 'package:flutter_application_1/features/login_page/ui/login_page_state_manager.dart';
import 'package:flutter_application_1/functions/material_color_creator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

late TweeetrixRepository database;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  database = await TweeetrixRepository.create();
  await database.createTestEnities();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: database,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: AppBarTheme(color: Colors.yellow),
            colorScheme: ColorScheme.fromSwatch(
                primarySwatch: createMaterialColor(Colors.black)),
            primaryColor: Colors.yellow,
            //textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
            scaffoldBackgroundColor: Color.fromARGB(255, 255, 248, 190)),
        home: LoginPage(),
      ),
    );
  }
}
