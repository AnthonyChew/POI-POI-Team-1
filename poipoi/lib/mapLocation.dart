import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'coordinates.dart';

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



void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late GoogleMapController myMapController;
  Set<Marker> _markers = {};
  static const LatLng _kMapCenter = LatLng(1.385110, 103.745000);
  static const CameraPosition _kInitialPosition = CameraPosition(
      target: _kMapCenter,
      zoom: 15.0,
      tilt: 0,
      bearing: 0
  );
  bool showLocation = true;
  bool locationOrAvatar = true;
  // List<Card> _addLevels = [];
  // List<Card> _addAvatars = [];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        backgroundColor: Colors.white60,
        appBar: AppBar(
          title: const Text('Fake Google Maps'),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),

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
                          // Expanded( // Empty Expanded to fill up space
                          //   child: Container(),
                          // ),
                          // Expanded(
                          //   child: ElevatedButton(
                          //       onPressed: () {
                          //         setState(() {
                          //           for (int i = 0; i < Coordinates().pokemon.length; i++) {
                          //             Coordinates().pokemon[i]['level'] = 1;
                          //           }
                          //         });
                          //       },
                          //       style: ElevatedButton.styleFrom(
                          //         backgroundColor: Colors.purpleAccent,
                          //         padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                          //       ),
                          //       child: const Icon(Icons.lock_reset_rounded),
                          //     ),
                          // ),
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
                          // Expanded( // Empty Expanded to fill up space
                          //   child: Container(),
                          // ),
                        ],
                      ),
                    ),
                    if (showLocation)
                      if (locationOrAvatar)
                        Expanded(
                          flex: 4,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: Coordinates().locations.length,
                              itemBuilder:(context, index){
                                if (
                                (_kMapCenter.latitude - Coordinates().locations[index]['latlong'].latitude) < 0.003 &&
                                    (_kMapCenter.latitude - Coordinates().locations[index]['latlong'].latitude) > -0.003 &&
                                    (_kMapCenter.longitude - Coordinates().locations[index]['latlong'].longitude) < 0.003 &&
                                    (_kMapCenter.longitude - Coordinates().locations[index]['latlong'].longitude) > -0.003
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
                                            child: Image.asset('assets/${Coordinates().locations[index]['name']}.jpg'),
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
                                                      title: Text('${Coordinates().locations[index]['name']}'),
                                                      content: Column(
                                                          children: [
                                                            Text("${Coordinates().locations[index]['id']}"),
                                                            Text("${Coordinates().locations[index]['latlong']}"),
                                                            Image.asset('assets/${Coordinates().locations[index]['name']}.jpg')
                                                          ]
                                                      ),
                                                    ));
                                                  },
                                                  child: Text(
                                                    '${Coordinates().locations[index]['name']}',
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
                        ),
                    if (!locationOrAvatar)
                      Expanded(
                        flex: 4,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: Coordinates().pokemon.length,
                          itemBuilder: (context, index) {
                            if (
                            (_kMapCenter.latitude - Coordinates().pokemon[index]['latlong'].latitude) < 0.003 &&
                                (_kMapCenter.latitude - Coordinates().pokemon[index]['latlong'].latitude) > -0.003 &&
                                (_kMapCenter.longitude - Coordinates().pokemon[index]['latlong'].longitude) < 0.003 &&
                                (_kMapCenter.longitude - Coordinates().pokemon[index]['latlong'].longitude) > -0.003
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
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage('assets/${Coordinates().pokemon[index]['name']}.jpg'),
                                          radius: 120.0,
                                          backgroundColor: Colors.black,
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
                                                title: Text('${Coordinates().pokemon[index]['name']}'),
                                                content: Column(
                                                  children: [
                                                    Text("${Coordinates().pokemon[index]['id']}"),
                                                    Text("${Coordinates().pokemon[index]['latlong']}"),
                                                    Image.asset('${Coordinates().pokemon[index]['image']}'),
                                                  ],
                                                ),
                                              ));
                                            },
                                            child: Text(
                                              '${Coordinates().pokemon[index]['name']}',
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
                      ),
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
      _markers = Coordinates().list.toSet();
    });

    return _markers;
  }

  void showDetails(int i) {
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text('${Coordinates().pokemon[i]['name']}'),
      content: Column(
        children: [
          Text('${Coordinates().pokemon[i]['id']}'),
          Text('${Coordinates().pokemon[i]['level']}'),
          Text('${Coordinates().pokemon[i]['latlong']}'),
          Text('${Coordinates().pokemon[i]['image']}'),
        ],
      ),
    ));
  }
}