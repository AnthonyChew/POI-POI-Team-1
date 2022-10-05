import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

bool accountFlag = false,
    nameFlag = false,
    birthdayFlag = false,
    sexFlag = false,
    picFlag = false,
    isMale = false,
    isFemale = false;

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key, required this.title});

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
  TextEditingController dateController = TextEditingController();

  void sexChanged(bool ismale) {
    setState(() {
      if (ismale)
      {
        if(isFemale) isFemale = false;
        isMale = true;
      }
      else
      {
        if(isMale) isMale = false;
        isFemale = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    dateController.text = "";
  }

  @override
  void deactivate() {
    super.deactivate();
    accountFlag = false;
    nameFlag = false;
    birthdayFlag = false;
    sexFlag = false;
    picFlag = false;
    isMale = false;
    isFemale = false;
  }

  @override
  void dispose() {
    super.dispose();
    accountFlag = false;
    nameFlag = false;
    birthdayFlag = false;
    sexFlag = false;
    picFlag = false;
    isMale = false;
    isFemale = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
          ),
        ),
        SafeArea(
          child: BackButton(
            onPressed: () => Navigator.pop(context, true),
          ),
          top: true,
        ),
        if (!accountFlag)
          Center(
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
                          style: TextStyle(fontSize: 32, color: Colors.white)),
                      SizedBox(height: 40),
                      FractionallySizedBox(
                          widthFactor: 0.8,
                          child: Column(
                            children: [
                              const TextField(
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
                                    labelText: 'Username',
                                  )),
                              SizedBox(height: 10),
                              const TextField(
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
                                  )),
                              SizedBox(height: 10),
                              const TextField(
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
                                  )),
                              SizedBox(height: 10),
                              FractionallySizedBox(
                                  widthFactor: 1,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      setState(() {
                                        accountFlag = true;
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
                                                  BorderRadius.circular(30.0))),
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
          ))
        else if (accountFlag && !nameFlag)
          Center(
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
                          style: TextStyle(fontSize: 32, color: Colors.white)),
                      SizedBox(height: 40),
                      FractionallySizedBox(
                          widthFactor: 0.8,
                          child: Column(
                            children: [
                              const TextField(
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
                                  )),
                              SizedBox(height: 10),
                              FractionallySizedBox(
                                  widthFactor: 1,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      setState(() {
                                        nameFlag = true;
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
                                                  BorderRadius.circular(30.0))),
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
          ))
        else if (accountFlag && nameFlag && !birthdayFlag)
          Center(
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
                          style: TextStyle(fontSize: 32, color: Colors.white)),
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
                                        color: Colors.white, fontSize: 24),
                                    controller: dateController,
                                    decoration: const InputDecoration(
                                        icon: Icon(Icons.calendar_today),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
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
                                          dateController.text =
                                              formattedDate.toString();
                                        });
                                      } else {
                                        print("Not selected");
                                      }
                                    },
                                  ))),
                              SizedBox(height: 10),
                              FractionallySizedBox(
                                  widthFactor: 1,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      setState(() {
                                        birthdayFlag = true;
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
                                                  BorderRadius.circular(30.0))),
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
          ))
        else if (accountFlag && nameFlag && birthdayFlag && !sexFlag)
          Center(
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
                          style: TextStyle(fontSize: 32, color: Colors.white)),
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
                              SizedBox(height: 40),
                              FractionallySizedBox(
                                  widthFactor: 1,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      setState(() {
                                        accountFlag = true;
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
                                                  BorderRadius.circular(30.0))),
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
