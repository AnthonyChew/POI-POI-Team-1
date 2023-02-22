import 'package:flutter/material.dart';
import 'location.dart';


class LocationCard extends StatelessWidget {

  final MyLocation location;
  final VoidCallback? delete;
  LocationCard({ required this.location, this.delete });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(16.0,16.0,16.0,0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child:InkWell(
        splashColor: Colors.black.withAlpha(30),
        onTap:(){
          print("Card Tapped");
        },


        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
          child: Column(
              crossAxisAlignment:CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  location.name,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey[600],
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6.0),
                // SizedBox(height: 6.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children:[
                    TextButton.icon(
                      label: Text('Delete'),
                      onPressed: delete,
                      style: TextButton.styleFrom(
                          fixedSize: const Size(100,40),
                          primary: Colors.white,
                          backgroundColor: Colors.black,
                          shape: const StadiumBorder()
                      ),
                      icon: Icon(Icons.delete),
                    ),],
                ),
              ]
          ),
        ),
      ),
    );
  }
}
