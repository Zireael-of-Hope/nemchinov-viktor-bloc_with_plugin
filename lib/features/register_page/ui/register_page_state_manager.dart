import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/tweetrix_repository.dart';
import 'package:flutter_application_1/features/register_page/bloc/register_bloc.dart';
import 'package:flutter_application_1/features/register_page/bloc/register_event.dart';
import 'package:flutter_application_1/features/register_page/bloc/register_state.dart';
import 'package:flutter_application_1/features/register_page/ui/page/register_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(context),
          ),
          iconTheme: IconThemeData(
            size: 40,
            color: Colors.black,
          ),
          centerTitle: true,
          title: Text('Tweetrix',
              style: GoogleFonts.roboto(
                  fontSize: 36,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
        ),
        body: BlocProvider<RegisterBloc>(
          create: (BuildContext context) => RegisterBloc(
              database: RepositoryProvider.of<TweeetrixRepository>(context)),
          child: BlocConsumer<RegisterBloc, RegisterState>(
            buildWhen: (previous, current) => current is RegisterBuildState,
            listenWhen: (previous, current) => current is RegisterListenState,
            listener: (context, state) {
              switch (state.runtimeType) {
                case CancelState:
                  Navigator.of(context).pop(context);
              }
            },
            builder: (context, state) {
              switch (state.runtimeType) {
                case InitialState:
                  return RegisterPageWidgets(
                      widgetState: state as InitialState);
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
                        RegisterPageWidgets(widgetState: state as LoadingState),
                        LinearProgressIndicator(),
                      ],
                    ),
                  );
                case RegisterFormState:
                  return RegisterPageWidgets(
                      widgetState: state as RegisterFormState);
                default:
                  BlocProvider.of<RegisterBloc>(context).add(Init());
                  return RegisterPageWidgets(
                      widgetState: state as InitialState);
              }
            },
          ),
        ),
      ),
    );
  }
}
