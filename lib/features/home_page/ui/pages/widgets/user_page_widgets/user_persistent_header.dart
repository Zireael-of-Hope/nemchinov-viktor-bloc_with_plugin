import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/consts.dart';

class UserPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  UserPersistentHeaderDelegate(
      {required this.minExtent,
      required this.maxExtent,
      required this.username,
      this.profileImage,
      this.profileAppBarImage});

  final double minExtent;
  final double maxExtent;
  final String username;
  final Uint8List? profileImage;
  final Uint8List? profileAppBarImage;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      children: [
        Container(
          //until images added
          height: maxExtent,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(const_falcon_image),
            ),
          ),
        ),
        Container(
          color: Colors.black.withOpacity(_darkening(shrinkOffset)),
          height: maxExtent,
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

  double _darkening(double shrinkOffset) {
    if (shrinkOffset < maxExtent - minExtent) {
      return 0.0 + max(0.0, shrinkOffset) / maxExtent;
    } else {
      return 0.75;
    }
  }
}
