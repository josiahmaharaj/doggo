import 'dart:async';

import 'package:flutter/material.dart';
import '../components/colors.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  Future<Null> _refreshCallbk() async {
    await Future.delayed(Duration(seconds: 5));
    print('refresh page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: emBackgroundColor,
      body: Container(
        child: RefreshIndicator(
          onRefresh: _refreshCallbk,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'Events',
                          style: TextStyle(color: emAccentColor),
                        ),
                        Text('Mobile'),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.notifications),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.person),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.settings),
                          onPressed: () {},
                        ),
                      ],
                    )
                  ],
                ),
                backgroundColor: emBackgroundColor,
                // expandedHeight: 200.0,
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  height: 100.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 100.0,
                        child: Card(
                          child: Text('June'),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 0.0),
                  height: 50.0,
                  child: Text(
                    'Events Filter',
                    style: TextStyle(color: emPrimaryColor),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  height: 100.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 100.0,
                        child: Card(
                            child: Column(
                          children: <Widget>[
                            Icon(Icons.star),
                            Text('Category')
                          ],
                        )),
                      );
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 0.0),
                  height: 50.0,
                  child: Text(
                    'Upcoming Events',
                    style: TextStyle(color: emPrimaryColor),
                  ),
                ),
              ),
              SliverFixedExtentList(
                itemExtent: 150.0,
                delegate: SliverChildListDelegate(
                  [
                    Container(color: Colors.red),
                    Container(color: Colors.purple),
                    Container(color: Colors.green),
                    Container(color: Colors.orange),
                    Container(color: Colors.yellow),
                    Container(color: Colors.pink),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
