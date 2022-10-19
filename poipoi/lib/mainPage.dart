import 'dart:async';
import 'dart:ui';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'post.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  final RoundedLoadingButtonController _btnController1 = RoundedLoadingButtonController();

  void _doSomething(RoundedLoadingButtonController controller) async {
    Timer(Duration(seconds: 10), () {
      controller.success();
    });
  }

  //hardcode.. need to edit later on..
  List<Post> posts = [
    Post(title: 'Punggol Park', description: 'Fun day at the park!!', username: 'Peter', imageURL: ['assets/pp1.JPG', 'assets/pp2.jpg'] ),

    Post(title: 'Woodlands Park', description: 'Fun day at the park!!', username: 'Peter', imageURL: ['assets/pp1.JPG', 'assets/pp2.jpg'] ),
  ];


  //page number
  int _selectedIndex = 0;

  //label for appBar
  static const List<Widget> _widgetOptions = <Widget>[
    Text('HOME', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'NotoSans', letterSpacing:2.0,)),
    Text('FIND BUDDY', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'NotoSans',letterSpacing:2.0,)),
    Text('AROUND ME', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'NotoSans',letterSpacing:2.0,)),
    Text('FAVORITES', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'NotoSans',letterSpacing:2.0,)),
  ];

  //used to change the index of page, to identify changed page
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: _widgetOptions.elementAt(_selectedIndex),
        centerTitle: true,
        backgroundColor: Colors.black,
        toolbarOpacity: 0.7,


      ),
      extendBody: true,

      body: Stack(
        children:[
        Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.center,
              image: AssetImage('assets/try.jpg', ),
              fit: BoxFit.cover,
            )
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
          child: Center(

          ),
        ),
      ),




        // only for Home Page!!
        ListView.builder(
          itemCount: posts.length,
          itemBuilder:(context, index){
            return Card(
              elevation: 20.0,
              shadowColor: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0,),
              child: Column(
                children:[
                Column(
                  children: [
                    Text(
                        posts[index].title,
                      style: TextStyle(fontSize:20.0, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                    ),
                      Text(
                        'Posted by ${posts[index].username}',
                        style: TextStyle(fontSize: 10.0, fontFamily: 'NotoSans',),
                      ),
                      Text(
                        posts[index]. description,
                        style: TextStyle(fontSize:12.0, fontFamily: 'NotoSans', letterSpacing:2.0, ),
                        textAlign: TextAlign.end,

                      ),
                  ],
                ),


                Container(
                  padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                  child: Image(
                    image: AssetImage(posts[index].imageURL[0],),
                  )
                ),

                  Container(

                    padding: const EdgeInsets.fromLTRB(2.0,10.0,250.0,10.0),
                    child: RoundedLoadingButton(
                      controller:_btnController1,
                      successIcon: Icons.pin_drop,
                      failedIcon: Icons.wrong_location,

                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10.0,2.0,5.0,2.0),
                          child: Row(
                            children: [
                            Icon( Icons.directions),
                            Text('Get Directions!', style: TextStyle(color: Colors.white)),
                            ]
                          ),
                        ),

                        onPressed: () => _doSomething(_btnController1),
                    ),
                  ),


              ]

              )
            );
          }



        ),

      ]

      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: DotNavigationBar(
          backgroundColor: Colors.grey.withOpacity(0.5),
          margin: EdgeInsets.only(left: 10, right: 10),
          currentIndex: _selectedIndex,
          dotIndicatorColor:Colors.transparent,
          unselectedItemColor: Colors.grey[300],
          paddingR: const EdgeInsets.symmetric(),
          //marginR: const EdgeInsets.symmetric(),
          onTap: _onItemTapped,
          items: [
            /// Home
            DotNavigationBarItem(
              icon: Icon(Icons.home, size: 40.0),
              selectedColor: Colors.amber[500],
            ),

            /// Find Buddy
            DotNavigationBarItem(
              icon: Icon(Icons.people, size: 40.0),
              selectedColor: Colors.amber[500],
            ),

            /// Around Me
            DotNavigationBarItem(
              icon: Icon(Icons.pin_drop, size: 40.0),
              selectedColor: Colors.amber[500],
            ),

            /// Favourites
            DotNavigationBarItem(
              icon: Icon(Icons.favorite, size: 40.0),
              selectedColor: Colors.amber[500],

            ),
          ],
        ),
      ),
    );
  }
}

