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
    return Scaffold(
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
    );
  }
}




