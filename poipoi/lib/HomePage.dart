import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:poipoi/Settings/SettingsPage.dart' as setting;
import 'package:poipoi/SignUpPage.dart' as signUp;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:poipoi/Model/GlobalData.dart' as global;
import 'Navigator.dart' as mainScreen;
import 'Settings/MyUser.dart';
import 'Settings/EditProfilePage.dart';
import 'package:path/path.dart';
import 'package:poipoi/Settings/change_password_page.dart';

void main() {
  runApp(const MyApp());
  Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'POI POI',
      theme: ThemeData(
          colorScheme: ThemeData().colorScheme.copyWith(),
          iconTheme: IconThemeData(color: Colors.white),
          fontFamily: GoogleFonts.openSans().fontFamily),
      home: const MyHomePage(title: 'Home Page'),
      routes: <String, WidgetBuilder>{
        "/signup": (BuildContext context) =>
            signUp.SignUpPage(title: 'Sign Up'),
        "/mainScreen": (BuildContext context) =>
            mainScreen.MainScreen(title: 'Main Screen'),
        "/settings": (BuildContext context) =>
            setting.Settings(title: 'Settings'),
        "/editProfile": (BuildContext context) => EditProfilePage(),
        "/restPassword": (BuildContext context) => ChangePasswordPage(),
        //add more routes here
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isEmailError = false, isPasswordError = false;
  final emailController = TextEditingController();
  final passwordContoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: const AssetImage("assets/images/main_bg.jpg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.6), BlendMode.darken),
                alignment: Alignment(-0.3, 0)),
          ),
      ignoreGestures: true,
      onRatingUpdate: (rating) {},
    );
  }

  Widget _buildPostList(snapshot) {
    int countfood = 1;
    return ListView.builder(
        itemCount: snapshot.data?.docs.length,
        itemBuilder: (context, index) {
          List <QueryDocumentSnapshot> items = [];
          items = snapshot.data?.docs;
          items.sort((a, b) {
            if (sortByRatings) {
              return b["rating"].compareTo(a["rating"]);
            }
            return a["NAME"].toLowerCase().compareTo(b["NAME"].toLowerCase());
          });
          QueryDocumentSnapshot<Object?>? documentSnapshot = items[index];
          return Card(
            color: Colors.black.withOpacity(0.8),
            margin: EdgeInsets.symmetric(
              vertical: 10.0, horizontal: 10.0,),
            child: Column(
                children: [
                  Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: const SizedBox(width: 10.0)
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Container(


                                    child: Text((documentSnapshot != null)
                                        ? (documentSnapshot["NAME"])
                                        : "",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white,
                                        fontSize: 25.0,
                                        fontFamily: 'NotoSans',
                                        fontWeight: FontWeight.bold,),
                                    ),
                                  ),
                                ),

                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    width: 10.0,
                                    child: PopupMenuButton(
                                      icon: Icon(
                                          Icons.more_vert, color: Colors.white),
                                      iconSize: 32.0,
                                      color: Colors.white,
                                      itemBuilder: (context) =>
                                      [
                                        PopupMenuItem<int>(
                                          value: 0,
                                          child: (documentSnapshot != null)
                                              ? (((documentSnapshot['liked']) !=
                                              0) ? Text(
                                              "Remove from Favourites",
                                              style: TextStyle(
                                                  color: Colors.black)) : Text(
                                              "Add to Favourites",
                                              style: TextStyle(
                                                  color: Colors.black)))
                                              : Text(""),
                                        ),
                                        PopupMenuItem<int>(
                                          value: 1,
                                          child: sortByRatings ? Text(
                                              "Sort A-Z", style: TextStyle(
                                              color: Colors.black)) : Text(
                                              "Sort by Ratings",
                                              style: TextStyle(
                                                  color: Colors.black)),
                                        ),

                                    final storageRef =
                                        FirebaseStorage.instance.ref();
                                    final islandRef = storageRef.child(
                                        FirebaseAuth.instance.currentUser!.uid);

                                      ],

                                      onSelected: (item) {
                                        switch (item) {
                                          case 0:
                                            setState(() { //-------------------------------------------------> database need to update too to save for next login
                                              (documentSnapshot != null)
                                                  ? ((documentSnapshot['liked']) !=
                                                  0
                                                  ? FirebaseFirestore.instance
                                                  .collection('gymLocation')
                                                  .doc(documentSnapshot.id)
                                                  .update({'liked': 0})
                                                  : FirebaseFirestore.instance
                                                  .collection('gymLocation')
                                                  .doc(documentSnapshot.id)
                                                  .update({'liked': 1}))
                                                  : "";
                                              //FirebaseFirestore.instance
                                              //                 .collection('healthyEateries')
                                              //                 .add({'liked': documentSnapshot[liked]})
                                            });

                                            break;
                                          case 1:
                                            setState(() {
                                              sortByRatings = !sortByRatings;
                                            });
                                            break;
                                        }
                                      },
                                    ),
                                  ),
                                ),

                              ]

                          ),
                        ),


                        Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(
                                    0.0, 10.0, 0.0, 10.0),
                                child: ImageSlideshow(
                                  indicatorColor: Colors.white,
                                  // onPageChanged: (value) { debugPrint('Page changed: $value');},
                                  isLoop: false,
                                  children: List.generate(
                                      posts.length, (i) {
                                    return
                                      Image.asset(
                                        "assets/images/food${countfood++ % 15 + 1}.jpg",
                                        fit: BoxFit.cover,
                                      );
                                  }
                                  ),
                                ),),
                              Container(
                                padding: EdgeInsets.only(top: 8.0),
                                child: _ratingBar((documentSnapshot != null)
                                    ? (documentSnapshot["rating"].toDouble())
                                    : (0.0)),
                              )
                            ]
                        ),
                      ]
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 5.0),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 5.0, right: 5.0, bottom: 2.0),

                              child: RoundedLoadingButton(
                                width: 60.0,
                                controller: _btnController1,
                                successIcon: Icons.pin_drop,
                                failedIcon: Icons.wrong_location,

                                child: Container(
                                  margin: EdgeInsets.only(right: 5.0,),
                                  padding: const EdgeInsets.fromLTRB(
                                      10.0, 2.0, 5.0, 5.0),
                                  child: Row(
                                      children: [
                                        Icon(Icons.directions),
                                        Text('Directions',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'NotoSans',
                                              fontWeight: FontWeight
                                                  .bold,)),
                                      ]
                                  ),
                                ),

                                onPressed: () =>
                                    _doSomething(_btnController1),
                              ),
                            ),

                            RoundedLoadingButton(
                              width: 20.0,
                              controller: _btnController1,
                              successIcon: Icons.pin_drop,
                              failedIcon: Icons.wrong_location,
                              color: Colors.white,
                              valueColor: Colors.blue,
                              errorColor: Colors.white,
                              successColor: Colors.white,

                              child: Container(
                                margin: EdgeInsets.only(right: 5.0,),
                                padding: const EdgeInsets.fromLTRB(
                                    10.0, 2.0, 5.0, 5.0),

                                child: Row(
                                    children: [
                                      Icon(Icons.gps_fixed_outlined,
                                        color: Colors.blue,),
                                      Text('Start', style: TextStyle(
                                        color: Colors.blue,
                                        fontFamily: 'NotoSans',
                                        fontWeight: FontWeight.bold,)),
                                    ]
                                ),
                              ),

                              onPressed: () =>
                                  _doSomething(_btnController1),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10.0),
                        child: IconButton(
                          iconSize: 40.0,
                          onPressed: () {
                            setState(() {
                              // posts[index].setClick(true);
                              _commentButtonPressed(
                                  (documentSnapshot != null) ? documentSnapshot
                                      .id : 0);
                            });
                          },
                          color: Colors.grey,
                          icon: Icon(Icons.chat_bubble_rounded),
                        ),
                      ),
                    ],
                  ),


                ]

            ),
          );
        }
    );
  }

}
