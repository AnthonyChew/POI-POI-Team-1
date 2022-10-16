/*
PlaceHolder for Favourite Page
 */

import 'package:flutter/material.dart';
import 'Cards/location.dart';
import 'Cards/location_card.dart';
import 'filter.dart';
import 'history.dart';


class FavouritePage extends StatefulWidget {
  @override
  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  List<Location> locations=[
    Location('Zhenghua Nature Park'),
    Location('Clementi ActiveSG Stadium'),
  ];

  Widget locationTemplate(location){
    return new LocationCard(location: location);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes:
        {
      //  '/': (context) => FavouritePage(),
        '/filter': (context) => Filter(),
        '/history': (context) => History(),
        },
        home:Scaffold(
      appBar: AppBar(
        title: Text('  Favorites',
          style: TextStyle(
            fontSize: 30.0,
            fontFamily: 'FredokaOne',
          ),
        ),
        actions: [IconButton(
            onPressed: (){
              Navigator.pushNamed(context, '/filter');
            },
            icon: Icon(
              Icons.filter_list_rounded,
              size: 30,
            ),
            color: Colors.white
        ),
          IconButton(
              onPressed: (){
                Navigator.pushNamed(context, '/history');
              },
              icon: Icon(
                Icons.history,
                size: 30,
              ),
              color: Colors.white
          ),],
        backgroundColor: Colors.black,
        toolbarHeight: 100,
      ),
      body: Stack(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              image: DecorationImage(
                image: new AssetImage("assets/images/image.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          new Column(
            children: locations.map((location) => LocationCard(
                location: location,
                delete:(){
                  setState((){
                    locations.remove(location);
                  });}

            )).toList(),
          ),
        ],
      ),
    ),
    );
  }
}




