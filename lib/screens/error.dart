import 'package:dog_ceo/screens/home.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage(String errorMessage);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            "assets/pug-min.jpg",
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
          Container(
              width: double.infinity,
              alignment: Alignment.topCenter,
              child: Column(
                children: <Widget>[
                  SafeArea(
                    child: Text(errorMessage ?? 'Error'),
                  ),
                  RaisedButton(
                    child: Text('Retry'),
                    onPressed: () {
                      Navigator.popAndPushNamed(context, '/');
                    },
                  )
                ],
              )),
        ],
      ),
    );
  }
}
