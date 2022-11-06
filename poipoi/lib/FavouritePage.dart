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
  final user_id;
  const FavouritePage({Key? key, required this.user_id}) : super(key: key);
  @override
  State<FavouritePage> createState() => _FavouritePageState(user_id);
}

class _FavouritePageState extends State<FavouritePage> {

  Widget _buildFavouriteList() {

    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('user_data').snapshots(),
        builder:(context,snapshot){
          if(snapshot.hasError){
            return Text('Something went wrong');
          }
          if(!snapshot.hasData){
            return Center( child: CircularProgressIndicator(),);
          }
          return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index){
                QueryDocumentSnapshot<Object?>? location = snapshot.data?.docs[index];
                return _buildFavouriteItem(location);
              }
          );
        }

    );

  }

  Widget _buildFavouriteItem(location){
    return new LocationCard(location: location);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
           Container(
            decoration: new BoxDecoration(
              image: DecorationImage(
                image: new AssetImage("assets/images/image.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          ),

            Column(children: <Widget> [Expanded(child: _buildFavouriteList()),],),
    ]
    ),
    );
  }
}




