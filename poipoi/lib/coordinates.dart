import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:developer';

class Coordinates {
  LatLng me = LatLng(1.385110, 103.745000);
  List<Map> pokemon = [
    {
      "id": '1',
      "name": "Bulbasaur",
      "level": 1,
      "latlong" : const LatLng(1.383500, 103.744000),
      "info": const InfoWindow(
        title: "Bulbasaur",
        snippet: '5 Star Rating',
      ),
      "image" : "assets/Bulbasaur.jpg",
    },
    {
      "id": const MarkerId('2'),
      "name": "Charmander",
      "level": 1,
      "latlong" : const LatLng(1.384120, 103.746000),
      "info": const InfoWindow(
        title: "Charmander",
        snippet: '5 Star Rating',
      ),
      "image" : "assets/Charmander.jpg",
    },
    {
      "id": 3,
      "name": "Squirtle",
      "level": 1,
      "latlong" : const LatLng(1.386100, 103.743010),
      "info": const InfoWindow(
        title: "Squirtle",
        snippet: '5 Star Rating',
      ),
      "image" : "assets/Squirtle.jpg",
    },
    {
      "id": 4,
      "name": "Ivysaur",
      "level": 1,
      "latlong" : const LatLng(1.387100, 103.743500),
      "info": const InfoWindow(
        title: "Ivysaur",
        snippet: '5 Star Rating',
      ),
      "image" : "assets/Ivysaur.jpg",
    },
    {
      "id": 5,
      "name": "Charmeleon",
      "level": 1,
      "latlong" : const LatLng(1.388000, 103.742000),
      "info": const InfoWindow(
        title: "Charmeleon",
        snippet: '5 Star Rating',
      ),
      "image" : "assets/Charmeleon.jpg",
    },
    {
      "id": 6,
      "name": "Wartortle",
      "level": 1,
      "latlong" : const LatLng(1.383500, 103.748500),
      "info": const InfoWindow(
        title: "Wartortle",
        snippet: '5 Star Rating',
      ),
      "image" : "assets/Wartortle.jpg",
    },
    {
      "id": '7',
      "name": "Venusaur",
      "level": 1,
      "latlong" : const LatLng(1.387300, 103.742100),
      "info": const InfoWindow(
        title: "Venusaur",
        snippet: '5 Star Rating',
      ),
      "image" : "assets/Venusaur.jpg",
    },
    {
      "id": '8',
      "name": "Charizard",
      "level": 1,
      "latlong" : const LatLng(1.381300, 103.740300),
      "info": const InfoWindow(
        title: "Charizard",
        snippet: '5 Star Rating',
      ),
      "image" : "assets/Charizard.jpg",
    },
    {
      "id": '9',
      "name": "Blastoise",
      "level": 1,
      "latlong" : const LatLng(1.379900, 103.740100),
      "info": const InfoWindow(
        title: "Blastoise",
        snippet: '5 Star Rating',
      ),
      "image" : "assets/Blastoise.jpg",
    },
  ];

  List<Map> locations = [
    {
      "id": '1',
      "name": "Bulbasaur",
      "level": 1,
      "latlong" : const LatLng(1.383850, 103.742800),
      "info": const InfoWindow(
        title: "Bulbasaur's Home",
        snippet: '5 Star Rating',
      ),
      "image" : "assets/Bulbasaur.jpg",
    },
    {
      "id": const MarkerId('2'),
      "name": "Charmander",
      "level": 1,
      "latlong" : const LatLng(1.384220, 103.744500),
      "info": const InfoWindow(
        title: "Charmander's Home",
        snippet: '5 Star Rating',
      ),
      "image" : "assets/Charmander.jpg",
    },
    {
      "id": 3,
      "name": "Squirtle",
      "level": 1,
      "latlong" : const LatLng(1.385100, 103.741010),
      "info": const InfoWindow(
        title: "Squirtle's Home",
        snippet: '5 Star Rating',
      ),
      "image" : "assets/Squirtle.jpg",
    },
    {
      "id": 4,
      "name": "Ivysaur",
      "level": 1,
      "latlong" : const LatLng(1.385100, 103.740500),
      "info": const InfoWindow(
        title: "Ivysaur's Home",
        snippet: '5 Star Rating',
      ),
      "image" : "assets/Ivysaur.jpg",
    },
    {
      "id": 5,
      "name": "Charmeleon",
      "level": 1,
      "latlong" : const LatLng(1.388500, 103.744000),
      "info": const InfoWindow(
        title: "Charmeleon's Home",
        snippet: '5 Star Rating',
      ),
      "image" : "assets/Charmeleon.jpg",
    },
    {
      "id": 6,
      "name": "Wartortle",
      "level": 1,
      "latlong" : const LatLng(1.381500, 103.740500),
      "info": const InfoWindow(
        title: "Wartortle's Home",
        snippet: '5 Star Rating',
      ),
      "image" : "assets/Wartortle.jpg",
    },
    {
      "id": '7',
      "name": "Venusaur",
      "level": 1,
      "latlong" : const LatLng(1.382100, 103.747600),
      "info": const InfoWindow(
        title: "Venusaur's Home",
        snippet: '5 Star Rating',
      ),
      "image" : "assets/Venusaur.jpg",
    },
    {
      "id": '8',
      "name": "Charizard",
      "level": 1,
      "latlong" : const LatLng(1.379300, 103.740300),
      "info": const InfoWindow(
        title: "Charizard's Home",
        snippet: '5 Star Rating',
      ),
      "image" : "assets/Charizard.jpg",
    },
    {
      "id": '9',
      "name": "Blastoise",
      "level": 1,
      "latlong" : const LatLng(1.384900, 103.745100),
      "info": const InfoWindow(
        title: "Blastoise's Home",
        snippet: '5 Star Rating',
      ),
      "image" : "assets/Blastoise.jpg",
    },
  ];

  late List<Marker> list = [
    Marker(
        markerId: MarkerId('My Location'),
        position: me,
        infoWindow: InfoWindow(
          title: 'My Location',
          snippet: '5 Star Rating',
        )
    ),
    for (int i = 1; i < pokemon.length; i++)
      if (
      (me.latitude - pokemon[i]['latlong'].latitude) < 0.003 &&
          (me.latitude - pokemon[i]['latlong'].latitude) > -0.003 &&
          (me.longitude - pokemon[i]['latlong'].longitude) < 0.003 &&
          (me.longitude - pokemon[i]['latlong'].longitude) > -0.003
      ) // set at 0.003 as 0.003 is apparently roughly 100m++
        Marker(
            markerId: MarkerId(pokemon[i]['id'].toString()),
            position: pokemon[i]['latlong'],
            infoWindow: pokemon[i]['info']
        )
  ];
}
