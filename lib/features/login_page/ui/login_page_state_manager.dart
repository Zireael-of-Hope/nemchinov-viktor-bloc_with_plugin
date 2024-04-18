import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/tweetrix_repository.dart';
import 'package:flutter_application_1/features/home_page/bloc/home_page_bloc/home_bloc.dart';
import 'package:flutter_application_1/features/home_page/ui/home_page.dart';
import 'package:flutter_application_1/features/login_page/bloc/login_bloc.dart';
import 'package:flutter_application_1/features/login_page/bloc/login_state.dart';
import 'package:flutter_application_1/features/login_page/ui/page/login_page.dart';
import 'package:flutter_application_1/features/register_page/ui/register_page_state_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Tweetrix',
            style: GoogleFonts.roboto(
                fontSize: 36, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(
              database: RepositoryProvider.of<TweeetrixRepository>(context)),
          child: BlocConsumer<LoginBloc, LoginState>(
            listenWhen: (previous, current) => current is LoginListenState,
            buildWhen: (previous, current) => current is LoginBuildState,
            listener: (context, state) {
              switch (state.runtimeType) {
                case GoToRegisterState:
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => RegisterPage()));
                  break;
                case GoToHomeState:
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) {
                    return BlocProvider(
                      create: (context) => HomeBloc(
                          database: RepositoryProvider.of<TweeetrixRepository>(
                              context),
                          user: state.user),
                      child: HomePage(user: (state as GoToHomeState).user),
                    );
                  }), (r) {
                    return false;
                  });
                  break;
              }
            },
            builder: (context, state) {
              switch (state.runtimeType) {
                case InitialState:
                  return LoginPageWidgets(widgetState: state as InitialState);
                case LoadingState:
                  return AbsorbPointer(
                    absorbing: true,
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: Colors.yellow.withOpacity(0.3),
                        ),
                        LoginPageWidgets(widgetState: state as LoadingState),
                        LinearProgressIndicator(),
                      ],
                    ),
                  );
                case LoginFormState:
                  return LoginPageWidgets(widgetState: state as LoginFormState);
                default:
                  throw Exception(
                      'Wrong state type has been returned from LoginBloc: ${state.runtimeType}');
              }
            },
          ),
        ),
      ),
    );
  }
}
