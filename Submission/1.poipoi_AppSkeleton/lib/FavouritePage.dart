/*
PlaceHolder for Favourite Page
 */
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Cards/location.dart';
import 'Cards/location_card.dart';
import 'Model/GlobalData.dart';
import "package:poipoi/Model/GlobalData.dart" as gbdata;
class FavouritePage extends StatefulWidget {
  @override
  State<FavouritePage> createState() => _FavouritePageState();
}
class _FavouritePageState extends State<FavouritePage> {
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
