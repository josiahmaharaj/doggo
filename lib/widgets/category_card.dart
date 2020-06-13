import 'package:events_mobile/components/colors.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      child: Card(
        color: emAccentColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              Icons.star,
              color: Colors.white,
              size: 30.0,
            ),
            Text(
              'Category',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
