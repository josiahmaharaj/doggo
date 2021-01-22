import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dog_ceo/components/connectivity_status.dart';
import 'package:dog_ceo/components/get_sub_breed.dart';
import 'package:dog_ceo/components/capitalize.dart';
import 'package:dog_ceo/components/colors.dart';
import 'package:dog_ceo/models/dog-image.dart';
import 'package:dog_ceo/screens/error.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:provider/provider.dart';
import 'package:retry/retry.dart';

bool hasError = false;
String errorMessage = '';

void playLocalAsset() async {
  Random rnd = new Random();
  int r = 1 + rnd.nextInt(4 - 1);
  String path = "assets/bark_" + r.toString() + ".mp3";
  AssetsAudioPlayer.newPlayer().open(
    Audio(path),
    autoStart: true,
    showNotification: true,
  );
}

// Try api call 3 times before sending error status
Future<DogImage> fetchBreedPhotos(String breed) async {
  String apiCall = 'https://dog.ceo/api/breed/' + breed + '/images';
  final response = await retry(
    () => http.get(apiCall).timeout(Duration(seconds: 5)),
    retryIf: (e) => e is SocketException || e is TimeoutException,
    maxAttempts: 3,
  );

  if (response.statusCode != 200) {
    hasError = true;
    errorMessage = "An error occured while trying to fetch dogs!";
  }
  return DogImage.fromJson(jsonDecode(response.body));
}

class Breed extends StatefulWidget {
  // Breed(Object data, {Key key}) : super(key: key);
  final String breed;
  Breed(this.breed);

  @override
  _BreedState createState() => _BreedState();
}

class _BreedState extends State<Breed> {
  Future<DogImage> futureDogImages;

  @override
  void initState() {
    super.initState();
    futureDogImages = fetchBreedPhotos(widget.breed);
  }

  Widget photoGrid(List<String> breedImage) {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemCount: breedImage.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.all(1.0),
          child: GridTile(
            footer: getSubBreed(breedImage[index]) == ''
                ? Container()
                : Container(
                    padding: EdgeInsets.all(2.0),
                    color: emPrimaryColor,
                    child: new Text(
                      getSubBreed(breedImage[index]),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
            child: InkWell(
              onTap: () {
                playLocalAsset();
              },
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/bone.gif',
                image: breedImage[index],
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget breedView() {
    // return Column(
    //   children: <Widget>[

    return FutureBuilder<DogImage>(
        future: futureDogImages,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
          } else if (!snapshot.hasData) {
            // return Text(snapshot.data.status);
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          // print(snapshot.data.imageLinks);
          return hasError
              ? ErrorPage(errorMessage = errorMessage)
              : photoGrid(snapshot.data.imageLinks);
        });
  }

  @override
  Widget build(BuildContext context) {
    // Listen for changes in connection
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    hasError = false;
    print(connectionStatus);
    return connectionStatus == ConnectivityStatus.Offline
        ? ErrorPage(errorMessage = "Ruh-roh! WiFi seems to be down.")
        : Scaffold(
            backgroundColor: emBackgroundColor,
            appBar: AppBar(
              title: Text(capitalize(widget.breed)),
              backgroundColor: emBackgroundColor,
              elevation: 0.1,
            ),
            body: breedView(),
          );
  }
}
