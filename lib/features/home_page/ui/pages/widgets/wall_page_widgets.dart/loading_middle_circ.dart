import 'package:flutter/material.dart';

class MiddleCircularLoading extends StatelessWidget {
  const MiddleCircularLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.35),
        Center(
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }
}
