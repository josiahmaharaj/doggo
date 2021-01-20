import 'package:dog_ceo/screens/breed.dart';
import 'package:flutter/material.dart';
import './screens/home.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Home());
      case '/breed':
        var data = settings.arguments;
        return MaterialPageRoute(builder: (_) => Breed(data));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
