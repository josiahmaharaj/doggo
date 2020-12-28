import 'package:dog_ceo/components/colors.dart';
import 'package:flutter/material.dart';

class CalendarCard extends StatelessWidget {
  const CalendarCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: emBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            '1',
            style: TextStyle(fontSize: 25, color: emPrimaryColor),
          ),
          Text(
            'June',
            style: TextStyle(color: emPrimaryColor),
          ),
        ],
      ),
    );
  }
}
