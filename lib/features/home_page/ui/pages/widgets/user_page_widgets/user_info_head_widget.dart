import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/home_page/ui/pages/widgets/user_page_widgets/description.dart';
import 'package:flutter_application_1/features/home_page/ui/pages/widgets/user_page_widgets/icon_text_date.dart';
import 'package:flutter_application_1/models/user_back_model.dart';
import 'package:google_fonts/google_fonts.dart';

class UserInfoHeadWidget extends StatelessWidget {
  const UserInfoHeadWidget({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                alignment: Alignment.bottomLeft,
                child: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 48,
                    child: CircleAvatar(
                      backgroundImage: user.profileImage != null
                          ? MemoryImage(user.profileImage!)
                          : null,
                      radius: 45,
                      child: Text(
                        user.profileImage == null ? user.username[0] : '',
                        style: GoogleFonts.roboto(fontSize: 40),
                      ),
                    )),
              ),
              Text(
                user.displayName,
                style: GoogleFonts.roboto(color: Colors.black, fontSize: 32),
              ),
              Text(
                '@${user.displayName}',
                style: GoogleFonts.roboto(color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              Description(description: user.profileDescription),
              SizedBox(height: 10),
              Wrap(
                children: [
                  IconTextDate(icon: Icons.card_travel, text: user.occupation),
                  IconTextDate(
                      icon: Icons.location_on_outlined, text: user.location),
                  IconTextDate(icon: Icons.link, text: user.linkToWebsite),
                  IconTextDate(
                      icon: Icons.calendar_month,
                      text: 'Joined',
                      date: user.joinDate,
                      dateFormat: DateFormat.monthYear),
                  IconTextDate(
                      icon: Icons.cake_outlined,
                      text: 'Born',
                      date: user.birthDate,
                      dateFormat: DateFormat.dayMonthYear),
                ],
              )
            ],
          ),
        ),
        Divider(thickness: 1)
      ],
    );
  }
}
