import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../components/colors.dart';
// import '../models/breeds.dart';


Future fetchBreedsList() async {
  final response =
      await http.get('https://dog.ceo/api/breeds/list/all');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(jsonDecode(response.body));
    return null;//Breeds.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load doggos');
  }
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> {
  Future futureBreeds;

  @override
  void initState() {
    super.initState();
    futureBreeds = fetchBreedsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: emBackgroundColor,
      body: Container(

      ),
    );
  }
}
