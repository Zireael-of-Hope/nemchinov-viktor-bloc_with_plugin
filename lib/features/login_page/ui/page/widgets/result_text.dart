import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/login_page/bloc/login_state.dart';

class Result extends StatelessWidget {
  Result({
    Key? key,
    required this.submitResult,
  }) : super(key: key);

  final SubmitResult submitResult;

  @override
  Widget build(BuildContext context) {
    return Text(
      submitResult.result,
      style: TextStyle(
        color: submitResult.isSuccess ? Colors.blue : Colors.red,
      ),
    );
  }
}
