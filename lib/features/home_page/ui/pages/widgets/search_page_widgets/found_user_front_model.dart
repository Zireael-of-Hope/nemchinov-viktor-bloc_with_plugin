import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_back_model.dart';
import 'package:google_fonts/google_fonts.dart';

class FoundUserModel extends StatelessWidget {
  const FoundUserModel({
    super.key,
    required this.thisUser,
    required this.thatUser,
    /*  required this.isFollowing */
  });

  final User thisUser;
  final User thatUser;
  /* final bool isFollowing; */

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          color: Colors.red.withOpacity(0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 25,
                  child: CircleAvatar(
                    backgroundImage: thatUser.profileImage != null
                        ? MemoryImage(thatUser.profileImage!)
                        : null,
                    radius: 25,
                    child: Center(
                      child: Text(
                        thatUser.profileImage == null
                            ? thatUser.username[0]
                            : '',
                        style: GoogleFonts.roboto(fontSize: 20),
                      ),
                    ),
                  )),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        RichText(
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: thatUser.displayName,
                                style: GoogleFonts.roboto(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: '\n'),
                              TextSpan(
                                text: '@${thatUser.username}',
                                style: GoogleFonts.roboto(
                                    fontSize: 18, color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                        Spacer(),
                        SizedBox(width: 10),
                        /* SubscribeButton(isFollowing: isFollowing, thisUser: thisUser, thatUser: thatUser) */
                      ],
                    ),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.only(right: 10),
                      child: Text(
                          thatUser.profileDescription != null
                              ? thatUser.profileDescription!
                              : '',
                          softWrap: true,
                          maxLines: 3,
                          style: GoogleFonts.roboto(
                              fontSize: 18, color: Colors.black)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(thickness: 1)
      ],
    );
  }
}
