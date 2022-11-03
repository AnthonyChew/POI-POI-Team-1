import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'Model/coordinates.dart';
import 'Model/GlobalData.dart' as gbdata;

// READ ME FIRST
// To run this file, first gotta set up google maps properly.

// Step 1: open android/app/src/main/AndroidManifest.xml
// add the following lines above the <application  tag with the same indentation
// <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
// <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
// next, add the following above the <activity tag
// <meta-data android:name="com.google.android.geo.API_KEY"
//    android:value="AIzaSyBeLdRcaromx-sBc4OZFB3I11jHlSWFSR8"/>

// Step 2: Open  android/app/build.gradle
// change the following lines:
// under
// Android {
//    defaultConfig {
//        minSdkVersion flutter.minSdkVersion     -> change it to minSdkVersion 20

// Step 3: Open pubspec.yaml
// under the dependencies:
// add google_maps_flutter: ^2.0.1 below flutter: sdk: flutter
// it should look like
// dependencies:
//   flutter:
//      sdk: flutter
//   google_maps_flutter: ^2.0.1



// void main() {
//   runApp(const MaterialApp(
//     home: AroundMePage(),
//   ));
// }

class AroundMePage extends StatefulWidget {
  const AroundMePage({Key? key}) : super(key: key);
  @override
  State<AroundMePage> createState() => _AroundMePageState();
}

class _AroundMePageState extends State<AroundMePage> {
  late GoogleMapController myMapController;
  Set<Marker> _markers = {};
  static LatLng me = LatLng(gbdata.position.latitude, gbdata.position.longitude);
  // Lot One: 1.385110, 103.745000
  static LatLng _kMapCenter = LatLng(gbdata.position.latitude, gbdata.position.longitude);
  static CameraPosition _kInitialPosition = CameraPosition(
      target: _kMapCenter,
      zoom: 15.0,
      tilt: 0,
      bearing: 0
  );
  bool showLocation = true;
  bool locationOrAvatar = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        backgroundColor: Colors.white60,


        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 300.0,
                      padding: EdgeInsets.all(10.0),
                      child: const TextField(
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Your Location',
                          hintText: 'Your Location',
                          fillColor: Colors.pink,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                      ),
                      color: Colors.black,
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 7,
                child: GoogleMap(
                  initialCameraPosition: _kInitialPosition,
                  markers: myMarker(),
                  mapType: MapType.normal,
                  myLocationEnabled: true,

                  onMapCreated: (controller) {
                    setState(() {
                      myMapController = controller;
                    });
                  },
                ),
              ),
              Expanded(
                flex: showLocation ? 2:1,
                // flex: 4,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                setState(()
                                {
                                  showLocation = !showLocation;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white54,
                              ),
                              child: const Icon(Icons.account_circle, color: Colors.black),
                            ),
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                setState(()
                                {
                                  locationOrAvatar = !locationOrAvatar;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white54,
                              ),
                              child: const Icon(Icons.accessibility_new, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (showLocation)
                      if (locationOrAvatar)
                        Expanded(
                          flex: 4,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: gbdata.parkDate.length,
                              itemBuilder:(context, index){
                                if (
                                  (me.latitude - gbdata.parkDate[index]['latlong'].latitude) < 0.033 &&
                                  (me.latitude - gbdata.parkDate[index]['latlong'].latitude) > -0.033 &&
                                  (me.longitude - gbdata.parkDate[index]['latlong'].longitude) < 0.033 &&
                                  (me.longitude - gbdata.parkDate[index]['latlong'].longitude) > -0.033
                                ) {
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    color: Colors.white54,
                                    elevation: 10,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.312,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: Image.asset(gbdata.parkDate[index]['image']),
                                          ),
                                          Expanded(
                                              flex: 1,
                                              child: Container(
                                                color: Colors.red[0],
                                                child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.orange[index * 100 + 100],
                                                    padding: const EdgeInsets.symmetric(
                                                        vertical: 1.0, horizontal: 1.0),
                                                  ),
                                                  onPressed: () {
                                                    showDialog(context: context, builder: (context)=> AlertDialog(
                                                      title: Text('${gbdata.parkDate[index]['name']}'),
                                                      content: Column(
                                                          children: [
                                                            Text("${gbdata.parkDate[index]['id']}"),
                                                            Text("${gbdata.parkDate[index]['latlong']}"),
                                                            Image.asset("${gbdata.parkDate[index]['image']}")
                                                          ]
                                                      ),
                                                    ));
                                                  },
                                                  child: Text(
                                                    '${gbdata.parkDate[index]['name']}',
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15.0,
                                                      letterSpacing: 1.0,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              )
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                return Container(
                                  width: 0,
                                );
                              }
                          ),
                        )
                      else if (!locationOrAvatar)
                        Expanded(
                          flex: 4,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: gbdata.healthyEateryDate.length,
                            itemBuilder: (context, index) {
                              if (
                                (me.latitude - gbdata.healthyEateryDate[index]['latlong'].latitude) < 0.033 &&
                                (me.latitude - gbdata.healthyEateryDate[index]['latlong'].latitude) > -0.033 &&
                                (me.longitude - gbdata.healthyEateryDate[index]['latlong'].longitude) < 0.033 &&
                                (me.longitude - gbdata.healthyEateryDate[index]['latlong'].longitude) > -0.033
                              ) {
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  color: Colors.black45,
                                  elevation: 10,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.312,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          // child: CircleAvatar(
                                          //   backgroundImage: AssetImage(gbdata.healthyEateryDate[index]['image']),
                                          //   radius: 120.0,
                                          //   backgroundColor: Colors.black,
                                          // )
                                            child: Image.asset(
                                              gbdata.healthyEateryDate[index]['image'],
                                              color: Colors.black26,
                                            ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            color: Colors.red[index + 50],
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.orange[index * 100 + 100],
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 1.0, horizontal: 1.0
                                                ),
                                              ),
                                              onPressed: () {
                                                showDialog(context: context, builder: (context) => AlertDialog(
                                                  title: Text('${gbdata.parkDate[index]['name']}'),
                                                  content: Column(
                                                    children: [
                                                      Text("${gbdata.healthyEateryDate[index]['id']}"),
                                                      Text("${gbdata.healthyEateryDate[index]['latlong']}"),
                                                      Image.asset("${gbdata.healthyEateryDate[index]['image']}"),
                                                    ],
                                                  ),
                                                ));
                                              },
                                              child: Text(
                                                '${gbdata.healthyEateryDate[index]['name']}',
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15.0,
                                                  letterSpacing: 1.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                              return Container(
                                width: 0,
                              );
                            },
                          ),
                        )
                  ],
                ),
              ),
            ] // Children
        )
    );
  }

  Set<Marker> myMarker() {
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_kMapCenter.toString()),
        position: _kMapCenter,
        infoWindow: const InfoWindow(
          title: 'My Location',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
      _markers = Coordinates().getMarkers(locationOrAvatar, me).toSet();
    });

    return _markers;
  }

  void showDetails(int i) {
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text('${gbdata.healthyEateryDate[i]['name']}'),
      content: Column(
        children: [
          Text('${gbdata.healthyEateryDate[i]['id']}'),
          Text('${gbdata.healthyEateryDate[i]['level']}'),
          Text('${gbdata.healthyEateryDate[i]['latlong']}'),
          Text('${gbdata.healthyEateryDate[i]['image']}'),
        ],
      ),
    ));
  }
}