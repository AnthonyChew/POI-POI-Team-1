import 'package:flutter/material.dart';
import 'visited_location.dart';
class VisitedLocation_Card extends StatelessWidget {

  final VisitedLocation visited_location;
  VisitedLocation_Card({ required this.visited_location});

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
                  visited_location.name,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey[600],
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  visited_location.date,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.grey[600],
                    fontFamily: 'OpenSans',
                  ),
                ),
                SizedBox(height: 6.0),
                // SizedBox(height: 6.0),

              ]
          ),
        ),
      ),
    );
  }
}
