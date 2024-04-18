import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/home_page/ui/pages/widgets/search_page_widgets/search_field.dart';

class SearchPersistentHeader extends SliverPersistentHeaderDelegate {
  SearchPersistentHeader(
      {required this.maxExtent,
      required this.searchFieldFocusNode,
      required this.searchFieldHeight,
      required this.searchFieldWidth})
      : minExtent = maxExtent;

  final FocusNode searchFieldFocusNode;
  final double maxExtent;
  final double minExtent;
  final double searchFieldHeight;
  final double searchFieldWidth;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.yellow,
      height: maxExtent,
      child: Row(
        children: [
          SizedBox(width: MediaQuery.of(context).size.width * 0.20),
          SearchField(
              focusNode: searchFieldFocusNode,
              height: searchFieldHeight,
              width: searchFieldWidth),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
