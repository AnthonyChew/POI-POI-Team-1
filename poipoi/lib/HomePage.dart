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
      debugShowCheckedModeBanner: false,
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
            ),
            Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(flex: 2),
                    Expanded(
                      flex: 8,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FractionallySizedBox(
                                widthFactor: 0.8,
                                child: Column(
                                  children: [
                                    TextField(
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                          BorderSide(width: 3, color: Colors.white),
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                        ),
                                        labelStyle: TextStyle(
                                          color: Colors.white, //<-- SEE HERE
                                        ),
                                        labelText: 'Email',
                                        errorText:
                                        isEmailError ? "Email not found." : null,
                                      ),
                                      controller: emailController,
                                    ),
                                    SizedBox(height: 10),
                                    TextField(
                                      style: TextStyle(color: Colors.white),
                                      obscureText: true,
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                          BorderSide(width: 3, color: Colors.white),
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                        ),
                                        labelStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                        labelText: 'Password',
                                        errorText:
                                        isPasswordError ? "Wrong password." : null,
                                      ),
                                      controller: passwordContoller,
                                    ),
                                    SizedBox(height: 10),
                                    FractionallySizedBox(
                                      widthFactor: 1,
                                      child: OutlinedButton(
                                        onPressed: () async {
                                          try {
                                            UserCredential userCredential = await global
                                                .auth
                                                .signInWithEmailAndPassword(
                                                email: emailController.text,
                                                password: passwordContoller.text);

                                            final docUser = await FirebaseFirestore
                                                .instance
                                                .collection("user_data")
                                                .doc(FirebaseAuth
                                                .instance.currentUser?.uid)
                                                .get();

                                            final storageRef =
                                            FirebaseStorage.instance.ref();
                                            final islandRef = storageRef.child(
                                                FirebaseAuth.instance.currentUser!.uid);

                                            String? path;
                                            var _appDocumentsDirectory =
                                            await getApplicationDocumentsDirectory();
                                            path = _appDocumentsDirectory.path;

                                            final String fileName = basename(
                                                FirebaseAuth.instance.currentUser!.uid +
                                                    "jpg"); // Filename without extension
                                            final filePath = '$path/$fileName';
                                            final file = File(filePath);

                                            final downloadTask =
                                            islandRef.writeToFile(file);
                                            downloadTask.snapshotEvents
                                                .listen((taskSnapshot) {
                                              switch (taskSnapshot.state) {
                                                case TaskState.running:
                                                // TODO: Handle this case.
                                                  break;
                                                case TaskState.paused:
                                                // TODO: Handle this case.
                                                  break;
                                                case TaskState.success:
                                                // TODO: Handle this case.
                                                  break;
                                                case TaskState.canceled:
                                                // TODO: Handle this case.
                                                  break;
                                                case TaskState.error:
                                                // TODO: Handle this case.
                                                  break;
                                              }
                                            });

                                            final user_data = MyUser(
                                                FirebaseAuth.instance.currentUser!.email
                                                    .toString(),
                                                docUser.get('name'),
                                                docUser.get('birthday'),
                                                docUser.get('is_male'),
                                                file);

                                            Navigator.pushNamed(context, '/mainScreen',
                                                arguments: user_data);
                                          } on FirebaseAuthException catch (e) {
                                            if (e.code == 'user-not-found') {
                                              setState(() {
                                                isEmailError = true;
                                              });
                                            }
                                            if (e.code == 'wrong-password') {
                                              setState(() {
                                                isPasswordError = true;
                                              });
                                            }
                                          } catch (e) {
                                            setState(() {
                                              isEmailError = true;
                                              isPasswordError = true;
                                            });
                                          }
                                        },
                                        style: ButtonStyle(
                                          foregroundColor:
                                          MaterialStateProperty.all(Colors.black),
                                          backgroundColor:
                                          MaterialStateProperty.all(Colors.white),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(30.0))),
                                        ),
                                        child: const Text(
                                          "Login",
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Text(
                                          'By clicking Log In, you agree with our Terms. Learn how we process your data in our Privacy Policy amd Cookies Policy.',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 16),
                                        ),
                                        SizedBox(height: 10),
                                        const Text(
                                          'Don\'t have an account yet?.',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 16),
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                context,
                                                '/signup',
                                              );
                                            },
                                            child: const Text("Sign Up",
                                                style: const TextStyle(
                                                    color: Colors.blue))),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                context,
                                                '/restPassword',
                                              );
                                            },
                                            child: const Text("Forget Password?",
                                                style: const TextStyle(
                                                    color: Colors.blue)))
                                      ],
                                    )
                                  ],
                                )),
                          ]),
                    ),
                  ],
                ))
          ],
        ));
  }
}