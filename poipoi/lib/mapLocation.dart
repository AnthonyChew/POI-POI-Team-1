import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'coordinates.dart';
// import 'avatars.dart';
// import 'pokemonLevels.dart';

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

  List<Map> pokemon = [
    {
      "id": 1,
      "name": "Bulbasaur",
      "level": 1,
    },
    {
      "id": 2,
      "name": "Charmander",
      "level": 1,
    },
    {
      "id": 3,
      "name": "Squirtle",
      "level": 1,
    },
    {
      "id": 4,
      "name": "Ivysaur",
      "level": 1,
    },
    {
      "id": 5,
      "name": "Charmeleon",
      "level": 1,
    },
    {
      "id": 6,
      "name": "Wartortle",
      "level": 1,
    },
  ];

  int _index = 0;
  bool showLocation = true;
  List<Card> _addLevels = [];

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
                          Align(
                            alignment: Alignment.centerLeft, // Reset level
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  for (int i = 0; i < pokemon.length; i++) {
                                    pokemon[i]['level'] = 1;
                                  }
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purpleAccent,
                                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                              ),
                              child: const Icon(Icons.lock_reset_rounded),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight, // Show Location
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
                        ],
                      ),
                    ),
                    if (showLocation)
                      Expanded(
                          flex: 4,
                          // child: PageView.builder(
                          // itemCount: pokemon.length,
                          // controller: PageController(viewportFraction: 0.7),
                          // onPageChanged: (int index) => setState(() => _index = index),
                          // itemBuilder: (_, i) {
                          //   return Transform.scale(
                          //     scale: i == _index ? 1 : 0.9,
                          //     child: pokemonLevels()[i],
                          //   );
                          // },
                          // ),
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            // physics: const PageScrollPhysics(),
                            children: pokemonLevels(),
                          )
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
      _markers = Coordinates().list.toSet();
    });

    return _markers;
  }

  // List<Expanded> myAvatars() {
  //   setState(() {
  //     _addImages = Avatars().list.toList();
  //   });
  //   return _addImages;
  // }

  List<Card> pokemonLevels() {
    setState(() {
      _addLevels = PokemonLevel(context).toList();
    });
    return _addLevels;
  }

  List<Card> PokemonLevel(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    List<Card> locations = [
      for (int i = 0; i < pokemon.length; i++)
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.white54,
          elevation: 10,
          child: Container(
            width: screenWidth * 0.312,
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Image.asset('assets/${pokemon[i]['name']}.jpg'),
                  // child: CircleAvatar(
                  //   backgroundImage: AssetImage('assets/Bulbasaur.jpg'),
                  //   radius: 80.0,
                  //   backgroundColor: Colors.transparent,
                  // ),
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.red[0],
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange[i * 100 + 100],
                          padding: const EdgeInsets.symmetric(
                              vertical: 1.0, horizontal: 1.0),
                        ),
                        onPressed: () {
                          setState(() {
                            pokemon[i]['level']++;
                          });
                        },
                        child: Text(
                          '${pokemon[i]['name']}: ${pokemon[i]['level']}',
                          style: TextStyle(
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
        ),

      // Container(
      //   width: screenWidth * 0.33,
      //   child: Column(
      //     children: [
      //       Expanded(
      //         flex: 4,
      //         child: Image.asset('assets/Charmander.jpg'),
      //         // child: CircleAvatar(
      //         //   backgroundImage: AssetImage('assets/Charmander.jpg'),
      //         //   radius: 80.0,
      //         //   backgroundColor: Colors.transparent,
      //         //
      //         // ),
      //       ),
      //       Expanded(
      //           flex: 1,
      //           child: Container(
      //             color: Colors.red[100],
      //             child: ElevatedButton(
      //               style: ElevatedButton.styleFrom(
      //                 backgroundColor: Colors.orange[100],
      //                 padding: const EdgeInsets.symmetric(
      //                     vertical: 1.0, horizontal: 1.0),
      //               ),
      //               onPressed: () {
      //                 setState(() {
      //                   pokemon[1]['level']++;
      //                 });
      //               },
      //               child: Text(
      //                 'Charmander: ${pokemon[1]['level']}',
      //                 style: TextStyle(
      //                   color: Colors.black,
      //                   fontSize: 15.0,
      //                   letterSpacing: 1.0,
      //                   fontWeight: FontWeight.bold,
      //                 ),
      //               ),
      //             ),
      //           )
      //       ),
      //     ],
      //   ),
      // ),
      // Container(
      //   width: screenWidth * 0.33,
      //   child: Column(
      //     children: [
      //       Expanded(
      //         flex: 4,
      //         child: Image.asset('assets/Squirtle.jpg'),
      //         // child: CircleAvatar(
      //         //   backgroundImage: AssetImage('assets/Squirtle.jpg'),
      //         //   radius: 80.0,
      //         //   backgroundColor: Colors.transparent,
      //         // ),
      //       ),
      //       Expanded(
      //           flex: 1,
      //           child: Container(
      //             color: Colors.red[200],
      //             child: ElevatedButton(
      //               style: ElevatedButton.styleFrom(
      //                 backgroundColor: Colors.orange[200],
      //                 padding: const EdgeInsets.symmetric(
      //                     vertical: 1.0, horizontal: 1.0),
      //               ),
      //               onPressed: () {
      //                 setState(() {
      //                   pokemon[2]['level']++;
      //                 });
      //               },
      //               child: Text(
      //                 'Squirtle: ${pokemon[2]['level']}',
      //                 style: TextStyle(
      //                   color: Colors.black,
      //                   fontSize: 15.0,
      //                   letterSpacing: 1.0,
      //                   fontWeight: FontWeight.bold,
      //                 ),
      //               ),
      //             ),
      //           )
      //       ),
      //     ],
      //   ),
      // ),
      // Container(
      //   width: screenWidth * 0.33,
      //   child: Column(
      //     children: [
      //       Expanded(
      //         flex: 4,
      //         child: Image.asset('assets/Ivysaur.jpg'),
      //         // child: CircleAvatar(
      //         //   backgroundImage: AssetImage('assets/Ivysaur.jpg'),
      //         //   radius: 80.0,
      //         //   backgroundColor: Colors.transparent,
      //         // ),
      //       ),
      //       Expanded(
      //           flex: 1,
      //           child: Container(
      //             color: Colors.red[300],
      //             child: ElevatedButton(
      //               style: ElevatedButton.styleFrom(
      //                 backgroundColor: Colors.orange[300],
      //                 padding: const EdgeInsets.symmetric(
      //                     vertical: 1.0, horizontal: 1.0),
      //               ),
      //               onPressed: () {
      //                 setState(() {
      //                   pokemon[3]['level']++;
      //                 });
      //               },
      //               child: Text(
      //                 'Ivysaur: ${pokemon[3]['level']}',
      //                 style: TextStyle(
      //                   color: Colors.black,
      //                   fontSize: 15.0,
      //                   letterSpacing: 1.0,
      //                   fontWeight: FontWeight.bold,
      //                 ),
      //               ),
      //             ),
      //           )
      //       ),
      //     ],
      //   ),
      // ),
      // Container(
      //   width: screenWidth * 0.33,
      //   child: Column(
      //     children: [
      //       Expanded(
      //         flex: 4,
      //         child: Image.asset('assets/Charmeleon.jpg'),
      //         // child: CircleAvatar(
      //         //   backgroundImage: AssetImage('assets/Charmeleon.jpg'),
      //         //   radius: 80.0,
      //         //   backgroundColor: Colors.transparent,
      //         // ),
      //       ),
      //       Expanded(
      //           flex: 1,
      //           child: Container(
      //             color: Colors.red[400],
      //             child: ElevatedButton(
      //               style: ElevatedButton.styleFrom(
      //                 backgroundColor: Colors.orange[400],
      //                 padding: const EdgeInsets.symmetric(
      //                     vertical: 1.0, horizontal: 1.0),
      //               ),
      //               onPressed: () {
      //                 setState(() {
      //                   pokemon[4]['level']++;
      //                 });
      //               },
      //               child: Text(
      //                 'Charmeleon: ${pokemon[4]['level']}',
      //                 style: TextStyle(
      //                   color: Colors.black,
      //                   fontSize: 15.0,
      //                   letterSpacing: 1.0,
      //                   fontWeight: FontWeight.bold,
      //                 ),
      //               ),
      //             ),
      //           )
      //       ),
      //     ],
      //   ),
      // ),
      // Container(
      //   width: screenWidth * 0.33,
      //   child: Column(
      //     children: [
      //       Expanded(
      //         flex: 4,
      //         child: Image.asset('assets/Wartortle.jpg'),
      //         // child: CircleAvatar(
      //         //   backgroundImage: AssetImage('assets/Wartortle.jpg'),
      //         //   radius: 80.0,
      //         //   backgroundColor: Colors.transparent,
      //         // ),
      //       ),
      //       Expanded(
      //           flex: 1,
      //           child: Container(
      //             color: Colors.red[500],
      //             child: ElevatedButton(
      //               style: ElevatedButton.styleFrom(
      //                 backgroundColor: Colors.orange[500],
      //                 padding: const EdgeInsets.symmetric(
      //                     vertical: 1.0, horizontal: 1.0),
      //               ),
      //               onPressed: () {
      //                 setState(() {
      //                   pokemon[5]['level']++;
      //                 });
      //               },
      //               child: Text(
      //                 'Wartortle: ${pokemon[5]['level']}',
      //                 style: TextStyle(
      //                   color: Colors.black,
      //                   fontSize: 15.0,
      //                   letterSpacing: 1.0,
      //                   fontWeight: FontWeight.bold,
      //                 ),
      //               ),
      //             ),
      //           )
      //       ),
      //     ],
      //   ),
      // ),
    ];
    return locations;
  }
}