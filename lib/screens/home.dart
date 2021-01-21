import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dog_ceo/components/capitalize.dart';
import 'package:dog_ceo/components/connectivity_status.dart';
import 'package:dog_ceo/models/dogs.dart';
import 'package:dog_ceo/screens/error.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retry/retry.dart';

import '../components/colors.dart';
// import '../models/breeds.dart';

bool hasError = false;
String errorMessage = '';

Future<Dogs> fetchDogs() async {
  final response = await retry(
    () => http
        .get('https://dog.ceo/api/breeds/list/all')
        .timeout(Duration(seconds: 5)),
    retryIf: (e) => e is SocketException || e is TimeoutException,
  );

  if (response.statusCode != 200) {
    hasError = true;
    errorMessage = "An error occured";
  }
  return Dogs.fromJson(jsonDecode(response.body));
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
          if (snapshot.hasError) {
            // Navigator.pushNamed(context, '/breed');
            errorMessage = snapshot.error.toString();
          } else if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return hasError
              ? ErrorPage(errorMessage)
              : CustomScrollView(
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: Container(
                        height: 180.0,
                        child: SafeArea(
                          top: true,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Dog CEO",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return Card(
                            margin: new EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 6.0),
                            child: FlatButton(
                              color: emTileColor,
                              padding: EdgeInsets.all(5),
                              onPressed: () {
                                // print(snapshot.data.breeds[index]);
                                Navigator.pushNamed(context, '/breed',
                                    arguments: snapshot.data.breeds[index]);
                              },
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                leading:
                                    Icon(Icons.pets, color: emPrimaryColor),
                                title: Text(
                                  capitalize(snapshot.data.breeds[index]),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                trailing: Icon(
                                  Icons.chevron_right,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                        childCount: snapshot.data.breeds.length,
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }

  // final topAppBar = AppBar(
  //   elevation: 0.1,
  //   backgroundColor: emBackgroundColor,
  //   title: Text('Dog CEO'),
  // );

  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    print(connectionStatus);
    hasError = false;
    return (connectionStatus == ConnectivityStatus.Offline ||
            connectionStatus == null)
        ? ErrorPage(errorMessage = "Whoops! WiFi seems to be down")
        : Scaffold(
            backgroundColor: emBackgroundColor,
            body: dogsList(),
          );
  }
}
