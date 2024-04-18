import 'package:flutter/material.dart';

enum DateFormat { year, monthYear, dayMonthYear }

class IconTextDate extends StatelessWidget {
  IconTextDate(
      {super.key, required this.icon, this.text, this.date, this.dateFormat});

  final IconData icon;
  final String? text;
  final DateTime? date;
  final DateFormat? dateFormat;

  final List<String> months = [
    '',
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  @override
  Widget build(BuildContext context) {
    if ((date != null && dateFormat == null) ||
        (date == null && dateFormat != null) ||
        (text == null && date == null)) {
      return Container(height: 0, width: 0);
    }

    return Row(
      children: [
        Icon(icon),
        SizedBox(width: 5),
        text != null ? Text(text!) : Container(height: 0, width: 0),
        text != null ? SizedBox(width: 5) : Container(height: 0, width: 0),
        date != null ? _buildDate(context) : Container(height: 0, width: 0),
        date != null ? SizedBox(width: 5) : Container(height: 0, width: 0)
      ],
    );
  }

  Widget _buildDate(BuildContext context) {
    switch (dateFormat!) {
      case DateFormat.year:
        return Text('${date!.year}');
      case DateFormat.monthYear:
        return Text('${months[date!.month]} ${date!.year}');
      case DateFormat.dayMonthYear:
        return Text('${date!.day} ${months[date!.month]}, ${date!.year}');
    }
  }
}
