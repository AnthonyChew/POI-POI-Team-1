import 'package:flutter/material.dart';
import 'Cards/visited_location.dart';
import 'Cards/VisitedLocation_card.dart';
import 'package:google_fonts/google_fonts.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<VisitedLocation> visited_locations=[
    VisitedLocation('Zhenghua Nature Park','08-11-2020'),
    VisitedLocation('Clementi ActiveSG Stadium','09-11-2021'),
  ];
  Widget visitedLocationTemplate(visited_location){
    return new VisitedLocation_Card(visited_location: visited_location);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.grey[200],
      appBar: AppBar(
        title: Text('VIEW HISTORY', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'NotoSans',letterSpacing:2.0,)),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: visited_locations.map((visited_location) => VisitedLocation_Card(
          visited_location: visited_location,
        )).toList(),
      ),
    );
  }
}
