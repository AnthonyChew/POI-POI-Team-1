import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:developer';
import 'package:poipoi/Model/GlobalData.dart' as gbdata;

class Coordinates {
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
                infoWindow: gbdata.healthyEateryDate[i]['info'],
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
