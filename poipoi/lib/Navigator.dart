/*
Main Screen.
Consist of App Bar and Bottom Navigation Bar which will show regardless of which tab
the user is in.

 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:poipoi/Settings/MyUser.dart';
import 'MainPage.dart';
import 'package:poipoi/Model/GlobalData.dart' as gbdata;
//import 'FindBuddyPage.dart';
import 'mapLocation.dart';
import 'FavouritePage.dart';
import 'Settings/SettingsPage.dart' as settings;
import 'HistoryPage.dart' as history;
import 'Model/filter.dart' as filter;
import 'package:geocoding/geocoding.dart';
import 'Cards/location.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;


  static const List<Widget> _appBarOptions = <Widget>[
    Text('HOME', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'NotoSans', letterSpacing:2.0,)),
    Text('AROUND ME', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'NotoSans',letterSpacing:2.0,)),
    Text('FAVOURITES', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'NotoSans',letterSpacing:2.0,)),
  ];


  List<Widget> _widgetOptions = <Widget>[
    HomePage(user_id: MyUser),
    AroundMePage(),
    FavouritePage(user_id: MyUser),
  ];

  void _onItemTapped(int index) async{
    await onload();
    setState(() {
      _selectedIndex = index;
    });
  }
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  @override
  void initState()
  {
    super.initState();
    FirebaseFirestore.instance.collection("healthy_eatery").get().then((snapshot) async {
      if (snapshot.docs.isNotEmpty) {
        for (int i = 0; i < snapshot.docs.length; i++) {
          Map<dynamic, dynamic> map = snapshot.docs[i].data();

          var points = map['coordinates'] as GeoPoint;
          gbdata.healthyEateryDate.add({"id":snapshot.docs[i].id ,"name": map['NAME'],"level":map['ADDRESSFLOORNUMBER'],
                      "latlong" : LatLng(points.latitude , points.longitude) ,
          "info": InfoWindow(
          title: map["ADDRESSTYPE"],
          snippet: map['DESCRIPTION'],
          ), "image" : map['PHOTOURL']
          });
        }
      }
    });

    FirebaseFirestore.instance.collection("park").get().then((snapshot) async {
      if (snapshot.docs.isNotEmpty) {
        for (int i = 0; i < snapshot.docs.length; i++) {
          Map<dynamic, dynamic> map = snapshot.docs[i].data();

          var points = map['coordinates'] as GeoPoint;
          gbdata.parkDate.add({"id":snapshot.docs[i].id ,"name": snapshot.docs[i].id,"level":map['ADDRESSFLOORNUMBER'],
            "latlong" : LatLng(points.latitude , points.longitude) ,
            "info": InfoWindow(
              title: map["ADDRESSSTREETNAME"],
              snippet: map['DESCRIPTION'],
            ), "image" : map['PHOTOURL']
          });
        }
      }
    });
    getPosition();

    onload();

  }

  Future<void> onload() async
  {

    gbdata.locations = [];
    DocumentSnapshot<Map<String, dynamic>> map = await FirebaseFirestore.instance.collection("user_data").doc(FirebaseAuth.instance.currentUser?.uid).get();

    List<dynamic> likeLocation = map["likeLocation"];

    for (int i = 0; i <gbdata.healthyEateryDate.length;i++ )
    {
      for(int j = 0; j < likeLocation.length; j++)
      {
        if(gbdata.healthyEateryDate[i]['id'] == likeLocation[j])
        {
          gbdata.locations.add(MyLocation(gbdata.healthyEateryDate[i]['name']));
        }
      }
    }
  }

  void getPosition() async
  {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
          gbdata.position = position;
      print("\n\n\n\nMy curr location is :" + gbdata.position.longitude.toString() + "," + gbdata.position.latitude.toString() + "\n\n\n\n");
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    final user_data = ModalRoute.of(context)!.settings.arguments as MyUser;

    return Scaffold(

    appBar: AppBar(
    title: _appBarOptions.elementAt(_selectedIndex),
    centerTitle: true,
    backgroundColor: Colors.black,
    toolbarOpacity: 0.7,
        automaticallyImplyLeading: false,
      actions:
      [

        if(_selectedIndex == 3)
        IconButton(
          onPressed: (){
            setState(() {
              Navigator.push(context, MaterialPageRoute(builder: (context) => filter.Filter()));
            });

          },
          icon: Icon(
            Icons.filter_list_rounded,
            size: 30,
          ),
          color: Colors.white
      ),
        if(_selectedIndex == 3)
        IconButton(
            onPressed: (){
              setState(() {
                Navigator.push(context, MaterialPageRoute(builder: (context) => history.History()));
              });
            },
            icon: Icon(
              Icons.history,
              size: 30,
            ),
            color: Colors.white
        ),

        IconButton(icon: Icon(Icons.settings,),
          onPressed: (){
            setState(() {
              Navigator.pushNamed(
                  context,
                  '/settings',
                  arguments: user_data);

            });
          },
        ),
      ],
    ),

    body: _widgetOptions.elementAt(_selectedIndex),

    bottomNavigationBar: Container(
    decoration: BoxDecoration(border:Border.all()),
    child: BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    currentIndex: _selectedIndex,
    backgroundColor: Colors.black,
    unselectedItemColor: Colors.white,

    selectedItemColor: Colors.blue,
    iconSize: 40,
    onTap: _onItemTapped,

    items: [
    /// Home
    BottomNavigationBarItem(
    icon: Icon(Icons.home, size: 40.0),

    label: "Home",
    ),

    /// Around Me
    BottomNavigationBarItem(
    icon: Icon(Icons.pin_drop, size: 40.0),
    backgroundColor: Colors.blue,
    label: "Around Me",
    ),

    /// Favourites
    BottomNavigationBarItem(
    icon: Icon(Icons.favorite, size: 40.0),
    backgroundColor: Colors.blue,
    label: "Favourite",

    ),
    ],
    ),
    ),


    );
  }
}
