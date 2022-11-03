/*
Main Screen.
Consist of App Bar and Bottom Navigation Bar which will show regardless of which tab
the user is in.
But within tabs can make it disappear by using push.Navigator() (see Screen2) if necessary
--> Maybe for AroundMePage
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:poipoi/Settings/MyUser.dart';
import 'HomePage.dart';
//import 'FindBuddyPage.dart';
import 'mapLocation.dart';
import 'FavouritePage.dart';
import 'Settings/SettingsPage.dart' as settings;
import 'HistoryPage.dart' as history;
import 'Model/filter.dart' as filter;
import 'package:geocoding/geocoding.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  List<Map> healthyEateryDate = [];
  List<Map> parkDate = [];

  static const List<Widget> _appBarOptions = <Widget>[
    Text('HOME', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'NotoSans', letterSpacing:2.0,)),
   // Text('FIND BUDDY', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'NotoSans',letterSpacing:2.0,)),
    Text('AROUND ME', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'NotoSans',letterSpacing:2.0,)),
    Text('FAVOURITES', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'NotoSans',letterSpacing:2.0,)),
  ];


  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
  //  FindBuddyPage(),
    AroundMePage(),
    FavouritePage(),
  ];

  void _onItemTapped(int index) async{

    setState(() {
      _selectedIndex = index;
    });
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
          healthyEateryDate.add({"id":i.toString() ,"name": map['NAME'],"level":map['ADDRESSFLOORNUMBER'],
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
          parkDate.add({"id":i.toString() ,"name": snapshot.docs[i].id,"level":map['ADDRESSFLOORNUMBER'],
            "latlong" : LatLng(points.latitude , points.longitude) ,
            "info": InfoWindow(
              title: map["ADDRESSSTREETNAME"],
              snippet: map['DESCRIPTION'],
            ), "image" : map['PHOTOURL']
          });
        }
      }
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

    /// Find Buddy
    // BottomNavigationBarItem(
    // icon: Icon(Icons.people, size: 40.0),
    // backgroundColor: Colors.blue,
    // label: "Find Buddy",
    // ),

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
