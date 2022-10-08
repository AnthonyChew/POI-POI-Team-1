/*
Main Screen.
Consist of App Bar and Bottom Navigation Bar which will show regardless of which tab
the user is in.
But within tabs can make it disappear by using push.Navigator() (see Screen2) if necessary
--> Maybe for AroundMePage
 */

import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'FindBuddyPage.dart';
import 'AroundMePage.dart';
import 'FavouritePage.dart';


/*
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}
*/

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
    Text('FIND BUDDY', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'NotoSans',letterSpacing:2.0,)),
    Text('AROUND ME', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'NotoSans',letterSpacing:2.0,)),
    Text('FAVOURITES', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'NotoSans',letterSpacing:2.0,)),
  ];


  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    FindBuddyPage(),
    AroundMePage(),
    FavouritePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    appBar: AppBar(
    title: _appBarOptions.elementAt(_selectedIndex),
    centerTitle: true,
    backgroundColor: Colors.black,
    toolbarOpacity: 0.7,

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
    BottomNavigationBarItem(
    icon: Icon(Icons.people, size: 40.0),
    backgroundColor: Colors.blue,
    label: "Find Buddy",
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
