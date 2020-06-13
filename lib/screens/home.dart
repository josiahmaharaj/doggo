import 'dart:async';

import 'package:events_mobile/widgets/calendar_card.dart';
import 'package:events_mobile/widgets/category_card.dart';
import 'package:events_mobile/widgets/event_card.dart';
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
                  height: 80.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 80.0,
                        child: CalendarCard(),
                      );
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.fromLTRB(25.0, 8.0, 25.0, 0.0),
                  height: 50.0,
                  child: Text(
                    'Events Filter',
                    style: TextStyle(color: emPrimaryColor, fontSize: 16.0),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  height: 90.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return CategoryCard();
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.fromLTRB(25.0, 8.0, 25.0, 0.0),
                  height: 50.0,
                  child: Text(
                    'Upcoming Events',
                    style: TextStyle(color: emPrimaryColor, fontSize: 16.0),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    EventCard(),
                    EventCard(),
                    EventCard(),
                    EventCard(),
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
