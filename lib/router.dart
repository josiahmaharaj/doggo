import 'package:flutter/material.dart';
import './screens/home.dart';
// import 'package:park_and_ride/bloc/service_session.dart';
// import 'package:park_and_ride/models/routes_model.dart';
// import 'package:park_and_ride/screens/notification_history.dart';
// import 'package:park_and_ride/screens/route_overview.dart';
// import 'package:park_and_ride/screens/user.dart';
// import 'package:park_and_ride/screens/route_to_work.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Home());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
