import 'dart:async';
import 'dart:convert';

import 'package:dog_ceo/models/dogs.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../components/colors.dart';
// import '../models/breeds.dart';

Future<Dogs> fetchDogs() async {
  final response = await http.get('https://dog.ceo/api/breeds/list/all');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Dogs.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load api');
  }
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<Dogs> futureDogs;

  @override
  void initState() {
    super.initState();
    futureDogs = fetchDogs();
  }

  Widget dogsList() {
    return Container(
      child: FutureBuilder<Dogs>(
        future: futureDogs,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            // print(snapshot.data.message);
            // return Text(snapshot.data.status);
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data.breeds.length,
            itemBuilder: (context, index) {
              return Card(
                child: FlatButton(
                  padding: EdgeInsets.all(5),
                  onPressed: () {
                    // print(snapshot.data.breeds[index]);
                    Navigator.pushNamed(context, '/breed',
                        arguments: snapshot.data.breeds[index]);
                  },
                  child: ListTile(
                    leading: Icon(Icons.pets),
                    title: Text(
                      snapshot.data.breeds[index],
                      style: TextStyle(color: Colors.black),
                    ),
                    trailing: Icon(Icons.chevron_right),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: emBackgroundColor,
      // appBar: AppBar(title: Text('Doggos')),
      body: dogsList(),
    );
  }
}
