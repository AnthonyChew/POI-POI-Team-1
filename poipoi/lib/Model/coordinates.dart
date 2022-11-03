import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:developer';
import 'package:poipoi/Model/GlobalData.dart' as gbdata;

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
        for (int i = 0; i < gbdata.healthyEateryDate.length; i++)
          if (
            (me.latitude - gbdata.healthyEateryDate[i]['latlong'].latitude) < 0.033 &&
            (me.latitude - gbdata.healthyEateryDate[i]['latlong'].latitude) > -0.033 &&
            (me.longitude - gbdata.healthyEateryDate[i]['latlong'].longitude) < 0.033 &&
            (me.longitude - gbdata.healthyEateryDate[i]['latlong'].longitude) > -0.033
          ) // set at 0.003 as 0.003 is apparently roughly 100m++
            Marker(
                markerId: MarkerId(gbdata.healthyEateryDate[i]['id'].toString()),
                position: gbdata.healthyEateryDate[i]['latlong'],
                infoWindow: gbdata.healthyEateryDate[i]['info']
            ),
      if (locationOrPpl)
        for (int i = 0; i < gbdata.parkDate.length; i++)
          if (
            (me.latitude - gbdata.parkDate[i]['latlong'].latitude) < 0.033 &&
            (me.latitude - gbdata.parkDate[i]['latlong'].latitude) > -0.033 &&
            (me.longitude - gbdata.parkDate[i]['latlong'].longitude) < 0.033 &&
            (me.longitude - gbdata.parkDate[i]['latlong'].longitude) > -0.033
          ) // set at 0.003 as 0.003 is apparently roughly 100m++
            Marker(
                markerId: MarkerId(gbdata.parkDate[i]['id'].toString()),
                position: gbdata.parkDate[i]['latlong'],
                infoWindow: gbdata.parkDate[i]['info']
            ),
    ];
    return list;
  }

}
