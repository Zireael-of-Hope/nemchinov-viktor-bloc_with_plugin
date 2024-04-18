import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/features/home_page/bloc/home_page_bloc/home_bloc.dart';
import 'package:flutter_application_1/features/home_page/ui/pages/widgets/wall_page_widgets.dart/emojis_bottom_sheet_grid_view.dart';
import 'package:flutter_application_1/models/tweet_back_model.dart';
import 'package:flutter_application_1/models/user_back_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void openEmojiModalSheet(
    {required BuildContext context, required Tweet tweet, required User user}) {
  final bloc = BlocProvider.of<HomeBloc>(context);
  showModalBottomSheet(
      backgroundColor: Color.fromARGB(255, 255, 248, 190),
      context: context,
      showDragHandle: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 10,
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 30),
                child: EmojiBottomSheetGridView(
                    emojis: emojiSymbols, tweet: tweet, user: user, bloc: bloc))
          ],
        );
      });
}
