import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:developer' as developer;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:poipoi/Model/GlobalData.dart' as global;
import 'package:poipoi/Settings/MyUser.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  @override
  final String title;

  @override
  State<SignUpPage> createState() => signUp();
}

class signUp extends State<SignUpPage> {
  bool accountFlag = false,
      nameFlag = false,
      birthdayFlag = false,
      sexFlag = false,
      picFlag = false,
      isMale = false,
      isFemale = false,
      isChoose = false;

  bool emailError = false,
      passwordError = false,
      passwordCError = false,
      nameError = false,
      dateError = false,
      sexError = false,
      picError = false;
  String emailErrorText = "", passwordErrorText = "", passwordCErrorText = "";

  File? image;

  String imagePath = "";
  File imageTemp = File("");

  TextEditingController dateController = TextEditingController();

  final emailController = TextEditingController();
  final passwordContoller = TextEditingController();
  final passwordCContoller = TextEditingController();
  final nameContoller = TextEditingController();

  void sexChanged(bool ismale) {
    setState(() {
      if (ismale) {
        if (isFemale) isFemale = false;
        isMale = true;
      } else {
        if (isMale) isMale = false;
        isFemale = true;
      }
    });
  }

  Future pickImage() async {
    try {
      PickedFile? image = await ImagePicker().getImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (image != null) {
        imageTemp = File(image.path);
        imagePath = image.path;
        setState(() {
          isChoose = true;
          picError = false;
        });
      }
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void regsiter() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        //Background image
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
          ),
        ),
        //Back Button container
        SafeArea(
          child: BackButton(
            onPressed: () => Navigator.pop(context, true),
          ),
          top: true,
        ),
        //Account container
        Column(
          children: [
            if (!accountFlag)
              Expanded(
                child: Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 8,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Accounts",
                                style: TextStyle(
                                    fontSize: 32, color: Colors.white)),
                            SizedBox(height: 40),
                            FractionallySizedBox(
                                widthFactor: 0.8,
                                child: Column(
                                  children: [
                                    TextField(
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 24),
                                      decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),
                                        labelStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                        errorText:
                                            emailError ? emailErrorText : null,
                                        labelText: 'Email',
                                      ),
                                      controller: emailController,
                                    ),
                                    SizedBox(height: 10),
                                    TextField(
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 24),
                                      obscureText: true,
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),
                                        labelStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                        labelText: 'Password',
                                        errorText: passwordError
                                            ? passwordErrorText
                                            : null,
                                      ),
                                      controller: passwordContoller,
                                    ),
                                    SizedBox(height: 10),
                                    TextField(
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 24),
                                      obscureText: true,
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),
                                        labelStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                        labelText: 'Confirm Password',
                                        errorText: passwordCError
                                            ? passwordCErrorText
                                            : null,
                                      ),
                                      controller: passwordCContoller,
                                    ),
                                    SizedBox(height: 10),
                                    FractionallySizedBox(
                                        widthFactor: 1,
                                        child: OutlinedButton(
                                          onPressed: ()  {
                                            setState(()  {
                                              if (emailController.text == "") {
                                                emailErrorText = "Please enter email";
                                                emailError = true;
                                              } else
                                                emailError = false;

                                              if (passwordContoller.text =="") {
                                                passwordErrorText = "Please enter password";
                                                passwordError = true;
                                              } else
                                                passwordError = false;

                                              if (passwordCContoller.text == "") {
                                                passwordCErrorText ="Please enter confirm email";
                                                passwordCError = true;
                                              } else
                                                passwordCError = false;

                                              if (!emailError &&!passwordError &&  !passwordCError)
                                              {

                                                try {
                                                  Future<UserCredential> userCredential = global.auth.createUserWithEmailAndPassword(
                                                      email: emailController.text,
                                                      password: passwordContoller.text);
                                                    accountFlag = true;
                                                } on FirebaseAuthException catch (e) {
                                                  if (e.code =='weak-password') {
                                                    passwordErrorText = 'The password provided is too weak.';
                                                    passwordError = true;
                                                  } else if (e.code =='email-already-in-use') {
                                                    emailErrorText = 'The account already exists for that email.';
                                                    emailError = true;
                                                  }
                                                } catch (e) {
                                                 print(e);
                                                  emailError = true;
                                                }

                                              }
                                            });


                                          },
                                          style: ButtonStyle(
                                            foregroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.black),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white),
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0))),
                                          ),
                                          child: const Text(
                                            "Continue",
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )),
                                  ],
                                )),
                          ]),
                    ),
                  ],
                )),
              )
            //name container
            else if (accountFlag && !nameFlag)
              Expanded(
                child: Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 8,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("My name is",
                                style: TextStyle(
                                    fontSize: 32, color: Colors.white)),
                            SizedBox(height: 40),
                            FractionallySizedBox(
                                widthFactor: 0.8,
                                child: Column(
                                  children: [
                                    TextField(
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 24),
                                      decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),
                                        labelStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                        labelText: 'First Name',
                                        errorText: nameError
                                            ? "Please enter your name"
                                            : null,
                                      ),
                                      controller: nameContoller,
                                    ),
                                    SizedBox(height: 10),
                                    FractionallySizedBox(
                                      widthFactor: 1,
                                      child: OutlinedButton(
                                        onPressed: () {
                                          setState(() {
                                            if (nameContoller.text == "") {
                                              nameError = true;
                                            } else {
                                              nameError = false;
                                              nameFlag = true;
                                            }
                                          });
                                        },
                                        style: ButtonStyle(
                                          foregroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.black),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0))),
                                        ),
                                        child: const Text(
                                          "Continue",
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ]),
                    ),
                  ],
                )),
              )
            //Birthday container
            else if (accountFlag && nameFlag && !birthdayFlag)
              Expanded(
                child: Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 8,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("My birthday is",
                                style: TextStyle(
                                    fontSize: 32, color: Colors.white)),
                            SizedBox(height: 40),
                            FractionallySizedBox(
                                widthFactor: 0.8,
                                child: Column(
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.all(10),
                                        child: Center(
                                          child: TextField(
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 24),
                                            controller: dateController,
                                            decoration: InputDecoration(
                                                icon:
                                                    Icon(Icons.calendar_today),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                errorText: dateError
                                                    ? "Please choose your birthday"
                                                    : null,
                                                labelText: "Enter Date"),
                                            readOnly: true,
                                            onTap: () async {
                                              DateTime? pickedDate =
                                                  await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(2000),
                                                lastDate: DateTime(2101),
                                              );
                                              if (pickedDate != null) {
                                                String formattedDate =
                                                    DateFormat("yyyy-MM-dd")
                                                        .format(pickedDate);

                                                setState(() {
                                                  dateError = false;
                                                  dateController.text =
                                                      formattedDate.toString();
                                                });
                                              } else {
                                                print("Not selected");
                                              }
                                            },
                                          ),
                                        )),
                                    SizedBox(height: 10),
                                    FractionallySizedBox(
                                        widthFactor: 1,
                                        child: OutlinedButton(
                                          onPressed: () {
                                            setState(() {
                                              if (dateController.text == "") {
                                                dateError = true;
                                              } else {
                                                dateError = false;
                                                birthdayFlag = true;
                                              }
                                            });
                                          },
                                          style: ButtonStyle(
                                            foregroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.black),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white),
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0))),
                                          ),
                                          child: const Text(
                                            "Continue",
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )),
                                  ],
                                )),
                          ]),
                    ),
                  ],
                )),
              )
            // Gender container
            else if (accountFlag && nameFlag && birthdayFlag && !sexFlag)
              Expanded(
                child: Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 8,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("I am a",
                                style: TextStyle(
                                    fontSize: 32, color: Colors.white)),
                            SizedBox(height: 40),
                            FractionallySizedBox(
                                widthFactor: 0.8,
                                child: Column(
                                  children: [
                                    FractionallySizedBox(
                                        widthFactor: 1,
                                        child: OutlinedButton(
                                          onPressed: () {
                                            setState(() {
                                              sexChanged(true);
                                            });
                                          },
                                          style: ButtonStyle(
                                            foregroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.transparent),
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            )),
                                            side: MaterialStateProperty.all(
                                                BorderSide(
                                                    width: 3,
                                                    color: isMale
                                                        ? Colors.black
                                                        : Colors.white)),
                                          ),
                                          child: const Text(
                                            "Male",
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )),
                                    SizedBox(height: 10),
                                    FractionallySizedBox(
                                        widthFactor: 1,
                                        child: OutlinedButton(
                                          onPressed: () {
                                            setState(() {
                                              sexChanged(false);
                                            });
                                          },
                                          style: ButtonStyle(
                                            foregroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.transparent),
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            )),
                                            side: MaterialStateProperty.all(
                                                BorderSide(
                                                    width: 3,
                                                    color: isFemale
                                                        ? Colors.black
                                                        : Colors.white)),
                                          ),
                                          child: const Text(
                                            "Female",
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )),
                                    if (sexError)
                                      FractionallySizedBox(
                                        widthFactor: 1,
                                        child: Text(
                                          "Please choose one",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red),
                                        ),
                                      ),
                                    SizedBox(height: 40),
                                    FractionallySizedBox(
                                        widthFactor: 1,
                                        child: OutlinedButton(
                                          onPressed: () {
                                            setState(() {
                                              if (isMale || isFemale) {
                                                sexError = false;
                                                sexFlag = true;
                                              } else
                                                sexError = true;
                                            });
                                          },
                                          style: ButtonStyle(
                                            foregroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.black),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white),
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0))),
                                          ),
                                          child: const Text(
                                            "Continue",
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )),
                                  ],
                                )),
                          ]),
                    ),
                  ],
                )),
              )
            else if (accountFlag &&
                nameFlag &&
                birthdayFlag &&
                sexFlag &&
                !picFlag)
              Expanded(
                child: Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 8,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Profile photo",
                                style: TextStyle(
                                    fontSize: 32, color: Colors.white)),
                            const SizedBox(height: 40),
                            FractionallySizedBox(
                                widthFactor: 0.8,
                                child: Column(children: [
                                  if (!isChoose)
                                    FractionallySizedBox(
                                      widthFactor: 1,
                                      child: IconButton(
                                        icon: Image.asset(
                                            'assets/images/PicIcon.png'),
                                        iconSize: 250,
                                        onPressed: () {
                                          pickImage();
                                        },
                                      ),
                                    )
                                  else
                                    FractionallySizedBox(
                                        widthFactor: 1,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.red,
                                          radius: 250,
                                          child: CircleAvatar(
                                            radius: 250 - 5,
                                            backgroundImage: Image.file(
                                              imageTemp,
                                              fit: BoxFit.cover,
                                            ).image,
                                          ),
                                        )),
                                  if (picError)
                                    FractionallySizedBox(
                                      widthFactor: 1,
                                      child: Text(
                                        "Please choose a profile picture",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red),
                                      ),
                                    ),
                                  const SizedBox(height: 40),
                                  FractionallySizedBox(
                                      widthFactor: 1,
                                      child: OutlinedButton(
                                        onPressed: () async {
                                          setState(() {
                                            if (!isChoose)
                                              picError = true;
                                            else {
                                              sexFlag = true;
                                            }
                                          });
                                          if (isChoose) {
                                            developer.log("Copying image");
                                            String? path;
                                            var _appDocumentsDirectory = await getApplicationDocumentsDirectory();
                                            path = _appDocumentsDirectory.path;

                                            final String fileName = basename(
                                                imagePath); // Filename without extension

                                            imageTemp = await imageTemp
                                                .copy('$path/$fileName');

                                            global.uuid = FirebaseAuth.instance.currentUser?.uid;

                                            final docUser = FirebaseFirestore
                                                .instance
                                                .collection("user_data")
                                                .doc(FirebaseAuth.instance.currentUser?.uid);

                                            final storageRef = FirebaseStorage.instance.ref();
                                            final imgRef = storageRef.child(FirebaseAuth.instance.currentUser!.uid.toString());
                                            await imgRef.putFile(imageTemp);

                                            await docUser.set({
                                              'name': nameContoller.text,
                                              'birthday': dateController.text,
                                              'is_male': isMale,
                                              'profile_pic_path': FirebaseAuth.instance.currentUser!.uid.toString()
                                            });

                                            final  user_data = MyUser(FirebaseAuth.instance.currentUser!.email.toString() ,nameContoller.text,dateController.text,isMale,imageTemp);

                                            Navigator.pushNamed(
                                              context,
                                              '/mainScreen',
                                              arguments: user_data);
                                          }
                                        },
                                        style: ButtonStyle(
                                          foregroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.black),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0))),
                                        ),
                                        child: const Text(
                                          "Continue",
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ))
                                ])),
                          ]),
                    ),
                  ],
                )),
              ),
          ],
        ),
        //Progress bar
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (!accountFlag)
              FractionallySizedBox(
                  widthFactor: 0.2,
                  child: Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.blueAccent, width: 2.5)),
                    child: null,
                  ))
            else if (accountFlag && !nameFlag)
              FractionallySizedBox(
                  widthFactor: 0.4,
                  child: Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.blueAccent, width: 2.5)),
                    child: null,
                  ))
            else if (accountFlag && nameFlag && !birthdayFlag)
              FractionallySizedBox(
                  widthFactor: 0.6,
                  child: Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.blueAccent, width: 2.5)),
                    child: null,
                  ))
            else if (accountFlag && nameFlag && birthdayFlag && !sexFlag)
              FractionallySizedBox(
                  widthFactor: 0.8,
                  child: Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.blueAccent, width: 2.5)),
                    child: null,
                  ))
            else if (accountFlag &&
                nameFlag &&
                birthdayFlag &&
                sexFlag &&
                !picFlag)
              FractionallySizedBox(
                  widthFactor: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.blueAccent, width: 2.5)),
                    child: null,
                  ))
          ],
        )
      ],
    ));
  }
}
