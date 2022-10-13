import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:developer';

class Coordinates {
  List<Map> pokemon = [
    {
      "id": '0',
      "name": "My location",
      "level": 1,
      "latlong" : const LatLng(1.385000, 103.745000),
      "info": const InfoWindow(
        title: "My Location",
        // snippet: '5 Star Rating',
      )
    },
    {
      "id": '1',
      "name": "Bulbasaur",
      "level": 1,
      "latlong" : const LatLng(1.383500, 103.744000),
      "info": const InfoWindow(
        title: "Bulbasaur",
        snippet: '5 Star Rating',
      )
    },
    {
      "id": const MarkerId('2'),
      "name": "Charmander",
      "level": 1,
      "latlong" : const LatLng(1.384120, 103.746000),
      "info": const InfoWindow(
        title: "Charmander",
        snippet: '5 Star Rating',
      )
    },
    {
      "id": 3,
      "name": "Squirtle",
      "level": 1,
      "latlong" : const LatLng(1.386100, 103.743010),
      "info": const InfoWindow(
        title: "Squirtle",
        snippet: '5 Star Rating',
      )
    },
    {
      "id": 4,
      "name": "Ivysaur",
      "level": 1,
      "latlong" : const LatLng(1.387100, 103.743500),
      "info": const InfoWindow(
        title: "Ivysaur",
        snippet: '5 Star Rating',
      )
    },
    {
      "id": 5,
      "name": "Charmeleon",
      "level": 1,
      "latlong" : const LatLng(1.388000, 103.742000),
      "info": const InfoWindow(
        title: "Charmeleon",
        snippet: '5 Star Rating',
      )
    },
    {
      "id": 6,
      "name": "Wartortle",
      "level": 1,
      "latlong" : const LatLng(1.383500, 103.748500),
      "info": const InfoWindow(
        title: "Wartortle",
        snippet: '5 Star Rating',
      )
    },
    {
      "id": '7',
      "name": "Venusaur",
      "level": 1,
      "latlong" : const LatLng(1.387300, 103.742100),
      "info": const InfoWindow(
        title: "Venusaur",
        snippet: '5 Star Rating',
      )
    },
    {
      "id": '8',
      "name": "Charizard",
      "level": 1,
      "latlong" : const LatLng(1.381300, 103.740300),
      "info": const InfoWindow(
        title: "Charizard",
        snippet: '5 Star Rating',
      )
    },
    {
      "id": '9',
      "name": "Blastoise",
      "level": 1,
      "latlong" : const LatLng(1.379900, 103.740100),
      "info": const InfoWindow(
        title: "Blastoise",
        snippet: '5 Star Rating',
      )
    },
  ];

  late List<Marker> list = [
    const Marker(
        markerId: MarkerId('My Location'),
        position: LatLng(1.385000, 103.745000),
        infoWindow: InfoWindow(
          title: 'My Location',
          snippet: '5 Star Rating',
        )
    ),
    for (int i = 1; i < pokemon.length; i++)
      if (
      (pokemon[0]['latlong'].latitude - pokemon[i]['latlong'].latitude) < 0.003 &&
          (pokemon[0]['latlong'].latitude - pokemon[i]['latlong'].latitude) > -0.003 &&
          (pokemon[0]['latlong'].longitude - pokemon[i]['latlong'].longitude) < 0.003 &&
          (pokemon[0]['latlong'].longitude - pokemon[i]['latlong'].longitude) > -0.003
      ) // set at 0.003 as 0.003 is apparently roughly 100m++
        Marker(
            markerId: MarkerId(pokemon[i]['id'].toString()),
            position: pokemon[i]['latlong'],
            infoWindow: pokemon[i]['info']
        )
    // const Marker(
    //   markerId: MarkerId('1'),
    //   position: LatLng(1.383500, 103.744000),
    //   infoWindow: InfoWindow(
    //     title: 'Location 1',
    //     snippet: '5 Star Rating',
    //   )
    // ),
    // const Marker(
    //     markerId: MarkerId('2'),
    //     position: LatLng(1.384120, 103.746000),
    //     infoWindow: InfoWindow(
    //       title: 'Location 2',
    //       snippet: '5 Star Rating',
    //     )
    // ),
    // const Marker(
    //     markerId: MarkerId('3'),
    //     position: LatLng(1.386100, 103.743010),
    //     infoWindow: InfoWindow(
    //       title: 'Location 3',
    //       snippet: '5 Star Rating',
    //     )
    // ),
  ];

  void lvlup(int i) {
    pokemon[i].update('level', (value) => value + 1);
  }

  void reset() {
    for (int i = 1; i < pokemon.length; i++) {
      pokemon[i].updateAll((key, value) => 1);
    }
  }
}
