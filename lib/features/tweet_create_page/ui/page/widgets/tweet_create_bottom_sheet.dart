import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/tweet_create_page/bloc/tweet_create_bloc.dart';
import 'package:flutter_application_1/features/tweet_create_page/ui/page/widgets/bottom_sheet_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void enableManagerBottomSheet(BuildContext context, bool isPublic) {
  final bloc = BlocProvider.of<TweetCreateBloc>(context);
  showModalBottomSheet(
    backgroundColor: Color.fromARGB(255, 255, 248, 190),
    context: context,
    showDragHandle: true,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20))),
    builder: (context) {
      return BlocProvider.value(
        value: bloc,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
                child: Text('Choose audience',
                    style: GoogleFonts.roboto(
                        fontSize: 34, fontWeight: FontWeight.bold))),
            Divider(thickness: 2),
            BottomSheetButton(
                isPublicButton: true,
                text: 'Public',
                icon: Icons.public,
                chosen: isPublic ? true : false),
            Divider(thickness: 2),
            BottomSheetButton(
                isPublicButton: false,
                text: 'Private',
                icon: Icons.group,
                chosen: isPublic ? false : true),
          ],
        ),
      );
    },
  );
}
