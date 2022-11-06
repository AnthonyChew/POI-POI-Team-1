/*
PlaceHolder for Favourite Page
 */

import 'package:flutter/material.dart';
import 'Cards/location.dart';
import 'Cards/location_card.dart';
import 'Model/filter.dart';
import 'HistoryPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class FavouritePage extends StatefulWidget {
  final user_id;
  const FavouritePage({Key? key, required this.user_id}) : super(key: key);
  @override
  State<FavouritePage> createState() => _FavouritePageState(user_id);
}

class _FavouritePageState extends State<FavouritePage> {

  _FavouritePageState(user_data);
  //load fav locations here i.e. if liked == true
  // List<Location> locations=[
  //   Location('Zhenghua Nature Park'),
  //   Location('Clementi ActiveSG Stadium'),
  // ];

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




