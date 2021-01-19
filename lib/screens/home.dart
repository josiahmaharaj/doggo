import 'dart:async';
import 'dart:collection';
import 'dart:convert';

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
    throw Exception('Failed to load album');
  }
}

class Dogs {
  final List breeds;
  final String status;

  Dogs({this.breeds, this.status});

  factory Dogs.fromJson(Map<String, dynamic> json) {
    List breeds = [];
    var dogCeoJson = json['message'];
    for (var key in dogCeoJson.keys) breeds.add(key);
    // Map<String,List> map = linkedHashMap.map((a, b) => MapEntry(a as String, b as List));

    return Dogs(breeds: breeds, status: json['status']);
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
            return CircularProgressIndicator();
          }
          return ListView.builder(
            itemCount: snapshot.data.breeds.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: Icon(Icons.pets),
                  title: Text(
                    snapshot.data.breeds[index],
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: Icon(Icons.chevron_right),
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
      appBar: AppBar(title: Text('Doggos')),
      body: dogsList(),
    );
  }
}
