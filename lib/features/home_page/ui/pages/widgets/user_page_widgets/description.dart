import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  Description({super.key, this.description});

  final String? description;

  @override
  Widget build(BuildContext context) {
    return description != null
        ? Text(description!)
        : Container(
            height: 0,
          );
  }
}
