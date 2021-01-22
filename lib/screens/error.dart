import 'package:dog_ceo/components/colors.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  ErrorPage(this.errorMessage);

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: emErrorColor,
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
                  SizedBox(
                    height: 20.0,
                  ),
                  SafeArea(
                    child: Text(
                      errorMessage,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    "",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  CircularProgressIndicator(),
                ],
              )),
        ],
      ),
    );
  }
}
