import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:developer';

class Coordinates {

  List<Map> pokemon = [
    {
      "id": '1',
      "name": "Bulbasaur",
      "level": 1,
      "latlong" : const LatLng(1.389500, 103.744000),
      "info": const InfoWindow(
        title: "Bulbasaur",
        snippet: '5 Star Rating',
      ),
      "image" : "assets/images/Locations/Bulbasaur.jpg",
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
      "image" : "assets/images/Locations/Charmander.jpg",
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
      "image" : "assets/images/Locations/Squirtle.jpg",
    },
    {
      "id": 4,
      "name": "Ivysaur",
      "level": 1,
      "latlong" : const LatLng(1.387100, 103.741500),
      "info": const InfoWindow(
        title: "Ivysaur",
        snippet: '5 Star Rating',
      ),
      "image" : "assets/images/Locations/Ivysaur.jpg",
    },
    {
      "id": 5,
      "name": "Charmeleon",
      "level": 1,
      "latlong" : const LatLng(1.384600, 103.742500),
      "info": const InfoWindow(
        title: "Charmeleon",
        snippet: '5 Star Rating',
      ),
      "image" : "assets/images/Locations/Charmeleon.jpg",
    },
    {
      "id": 6,
      "name": "Wartortle",
      "level": 1,
      "latlong" : const LatLng(1.383500, 103.747500),
      "info": const InfoWindow(
        title: "Wartortle",
        snippet: '5 Star Rating',
      ),
      "image" : "assets/images/Locations/Wartortle.jpg",
    },
    {
      "id": '7',
      "name": "Venusaur",
      "level": 1,
      "latlong" : const LatLng(1.387300, 103.741100),
      "info": const InfoWindow(
        title: "Venusaur",
        snippet: '5 Star Rating',
      ),
      "image" : "assets/images/Locations/Venusaur.jpg",
    },
    {
      "id": '8',
      "name": "Charizard",
      "level": 1,
      "latlong" : const LatLng(1.383300, 103.742300),
      "info": const InfoWindow(
        title: "Charizard",
        snippet: '5 Star Rating',
      ),
      "image" : "assets/images/Locations/Charizard.jpg",
    },
    {
      "id": '9',
      "name": "Blastoise",
      "level": 1,
      "latlong" : const LatLng(1.379900, 103.745800),
      "info": const InfoWindow(
        title: "Blastoise",
        snippet: '5 Star Rating',
      ),
      "image" : "assets/images/Locations/Blastoise.jpg",
    },
  ];

  List<Map> locations = [
    {
      "id": '1',
      "name": "Bulbasaur",
      "level": 1,
      "latlong" : const LatLng(1.381850, 103.743800),
      "info": const InfoWindow(
        title: "Bulbasaur's Home",
        snippet: '5 Star Rating',
      ),
      "image" : "assets/images/Locations/Bulbasaur.jpg",
    },
    {
      "id": const MarkerId('2'),
      "name": "Charmander",
      "level": 1,
      "latlong" : const LatLng(1.389220, 103.744500),
      "info": const InfoWindow(
        title: "Charmander's Home",
        snippet: '5 Star Rating',
      ),
      "image" : "assets/images/Locations/Charmander.jpg",
    },
    {
      "id": 3,
      "name": "Squirtle",
      "level": 1,
      "latlong" : const LatLng(1.385100, 103.746010),
      "info": const InfoWindow(
        title: "Squirtle's Home",
        snippet: '5 Star Rating',
      ),
      "image" : "assets/images/Locations/Squirtle.jpg",
    },
    {
      "id": 4,
      "name": "Ivysaur",
      "level": 1,
      "latlong" : const LatLng(1.385100, 103.745500),
      "info": const InfoWindow(
        title: "Ivysaur's Home",
        snippet: '5 Star Rating',
      ),
      "image" : "assets/images/Locations/Ivysaur.jpg",
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
      "image" : "assets/images/Locations/Charmeleon.jpg",
    },
    {
      "id": 6,
      "name": "Wartortle",
      "level": 1,
      "latlong" : const LatLng(1.384500, 103.745900),
      "info": const InfoWindow(
        title: "Wartortle's Home",
        snippet: '5 Star Rating',
      ),
      "image" : "assets/images/Locations/Wartortle.jpg",
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
      "image" : "assets/images/Locations/Venusaur.jpg",
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
      "image" : "assets/images/Locations/Charizard.jpg",
    },
    {
      "id": '9',
      "name": "Blastoise",
      "level": 1,
      "latlong" : const LatLng(1.381900, 103.745100),
      "info": const InfoWindow(
        title: "Blastoise's Home",
        snippet: '5 Star Rating',
      ),
      "image" : "assets/images/Locations/Blastoise.jpg",
    },
  ];

  List<Marker> getMarkers(bool locationOrPpl, LatLng me) {
    late List<Marker> list = [
      Marker(
          markerId: MarkerId('My Location'),
          position: me,
          infoWindow: InfoWindow(
            title: 'My Location',
            snippet: '5 Star Rating',
          )
      ),
      if (!locationOrPpl)
        for (int i = 0; i < pokemon.length; i++)
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
            ),
      if (locationOrPpl)
        for (int i = 0; i < locations.length; i++)
          if (
            (me.latitude - locations[i]['latlong'].latitude) < 0.003 &&
            (me.latitude - locations[i]['latlong'].latitude) > -0.003 &&
            (me.longitude - locations[i]['latlong'].longitude) < 0.003 &&
            (me.longitude - locations[i]['latlong'].longitude) > -0.003
          ) // set at 0.003 as 0.003 is apparently roughly 100m++
            Marker(
                markerId: MarkerId(locations[i]['id'].toString()),
                position: locations[i]['latlong'],
                infoWindow: locations[i]['info']
            ),
    ];
    return list;
  }

}
