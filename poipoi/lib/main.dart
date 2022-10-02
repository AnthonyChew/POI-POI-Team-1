

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'POI POI',
      theme: ThemeData(
        fontFamily: GoogleFonts.openSans().fontFamily
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        body: new Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/images/main_bg.jpg"),
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
                  alignment: Alignment(-0.3, 0)),
              ),
            ),
            new Container(
                width: 50.00,
                height: 50.00,
                margin: EdgeInsets.only(top: 30),
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: ExactAssetImage('assets/images/logo.png'),
                    fit: BoxFit.contain,
                  ),
                )),
            new Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(flex: 4,),
                new Expanded(
                    flex: 4,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                    new FractionallySizedBox(
                        widthFactor: 0.8,
                        child: Text('By clicking Log In, you agree with our Terms. Learn how we process your data in our Privacy Policy amd Cookies Policy.',
                            style: TextStyle(color: Colors.white,fontSize: 16) )
                    ),

                    new Container(
                        margin: EdgeInsets.only(top:20),
                        child : new FractionallySizedBox(
                          widthFactor: 0.8,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                foregroundColor: Color.fromARGB(255, 157, 157, 157),
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                )
                            ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                            onPressed: (){},
                            child: Image.asset('assets/images/socialbutton/googlebutton.png' ),
                          ),
                        )
                    ),
                    new Container(
                        margin: EdgeInsets.only(top:20),
                        child : new FractionallySizedBox(
                          widthFactor: 0.8,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black,
                              backgroundColor: Color.fromARGB(255, 24,119,242),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),),
                            ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                            onPressed: (){},
                            child: Image.asset('assets/images/socialbutton/facebookbutton.png' ),
                          ),
                        )
                    ),
                          new Container(
                              margin: EdgeInsets.only(top:10),
                              child : TextButton(onPressed: (){},
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  textStyle: TextStyle(decoration: TextDecoration.underline,)
                                ),
                                        child: Text('Use email & password'),
                              ),
                          ),
                  ]
                  ),
                ),

              ],
              )
            )
          ],
        )
    );
  }
}