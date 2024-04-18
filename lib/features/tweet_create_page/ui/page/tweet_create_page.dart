import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/tweet_create_page/bloc/tweet_create_bloc.dart';
import 'package:flutter_application_1/features/tweet_create_page/bloc/tweet_create_event.dart';
import 'package:flutter_application_1/features/tweet_create_page/bloc/tweet_create_state.dart';
import 'package:flutter_application_1/features/tweet_create_page/ui/page/widgets/tweet_create_bottom_sheet.dart';
import 'package:flutter_application_1/models/user_back_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class TweetCreatePageWidgets extends StatefulWidget {
  TweetCreatePageWidgets({Key? key, required this.state, required this.user})
      : super(key: key);

  final TweetCreatePageState state;
  final User user;

  @override
  State<TweetCreatePageWidgets> createState() => _TweetCreatePageWidgetsState();
}

class _TweetCreatePageWidgetsState extends State<TweetCreatePageWidgets> {
  TextEditingController controller = TextEditingController();
  bool lastValueEmpty = true;
  final Color? audienceColor = Colors.black;

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      if (lastValueEmpty && controller.text != '') {
        BlocProvider.of<TweetCreateBloc>(context).add(EnableButton());
        lastValueEmpty = false;
      }
      if (controller.text == '') {
        BlocProvider.of<TweetCreateBloc>(context).add(DisableButton());
        lastValueEmpty = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop()),
        iconTheme: IconThemeData(
          size: 40,
          color: Colors.black,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all<double>(0),
                    backgroundColor: state.tweetButtonEnabled
                        ? MaterialStateProperty.all<Color>(Colors.black)
                        : MaterialStateProperty.all<Color>(Colors.yellow),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)))),
                onPressed: state.tweetButtonEnabled
                    ? () => BlocProvider.of<TweetCreateBloc>(context).add(
                        MakeTweet(
                            tweetText: controller.text,
                            isPublic: state.isPublic,
                            user: widget.user))
                    : null,
                child: Text('Tweet',
                    style: GoogleFonts.roboto(
                        fontSize: 22,
                        color: Colors.yellow,
                        fontWeight: FontWeight.bold))),
          )
        ],
      ),
      body: Container(
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
          child: Row(
            children: [
              Column(
                children: [
                  CircleAvatar(
                    backgroundImage: widget.user.profileImage != null
                        ? MemoryImage(widget.user.profileImage!)
                        : null,
                    radius: 27,
                    child: Text(
                      widget.user.profileImage == null
                          ? widget.user.username[0]
                          : '',
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 9,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      splashColor: Colors.black,
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                        height: 40,
                        width: 120,
                        decoration: BoxDecoration(
                            color: Colors.yellow.withOpacity(0.3),
                            border: Border.all(width: 2, color: audienceColor!),
                            borderRadius: BorderRadius.circular(25)),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                state.isPublic ? 'Public' : 'Private',
                                style: GoogleFonts.roboto(
                                    fontSize: 22, color: audienceColor),
                              ),
                              Icon(Icons.keyboard_arrow_down),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        enableManagerBottomSheet(context, state.isPublic);
                      },
                    ),
                    SizedBox(height: 7),
                    Expanded(
                      child: TextField(
                        style: GoogleFonts.roboto(fontSize: 22),
                        maxLines: null,
                        expands: true,
                        controller: controller,
                        decoration: InputDecoration(
                            hintText: 'What\'s happening?',
                            border: InputBorder.none),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
