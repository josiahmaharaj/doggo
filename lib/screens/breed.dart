import 'dart:async';
import 'dart:convert';

import 'package:dog_ceo/components/get_sub_breed.dart';
import 'package:dog_ceo/models/dog-image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../components/colors.dart';

Future<DogImage> fetchBreedPhotos(String breed) async {
  String apiCall = 'https://dog.ceo/api/breed/' + breed + '/images';
  final response = await http.get(apiCall);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return DogImage.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load api');
  }
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
    return CustomScrollView(
      // shrinkWrap: true,
      slivers: <Widget>[
        // SliverAppBar(
        //   pinned: true,
        //   flexibleSpace: FlexibleSpaceBar(
        //     title: Text(widget.breed),
        //   ),
        // ),
        SliverToBoxAdapter(
          child: SafeArea(
            top: true,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.navigate_before,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  widget.breed[0].toUpperCase() + widget.breed.substring(1),
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
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 0.0,
            mainAxisSpacing: 0.0,
          ),
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.all(8.0),
              child: GridTile(
                footer: new Text(
                  getSubBreed(breedImage[index]),
                  style: TextStyle(
                    color: Colors.black,
                    backgroundColor: emPrimaryColor,
                  ),
                ),
                child: new FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: breedImage[index],
                  fit: BoxFit.cover,
                ), //just for testing, will fill with image later
              ),
            );
          }, childCount: breedImage.length),
        ),
      ],
    );
  }

  Widget breedView() {
    // return Column(
    //   children: <Widget>[

    return FutureBuilder<DogImage>(
        future: futureDogImages,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            // return Text(snapshot.data.status);
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          // print(snapshot.data.imageLinks);
          var breedImage = snapshot.data.imageLinks;
          return photoGrid(breedImage);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: emBackgroundColor,
      // appBar: AppBar(title: Text('Doggos')),
      body: breedView(),
    );
  }
}
