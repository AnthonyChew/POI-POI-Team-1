import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

bool accountFlag = false , nameFlag = false;

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<SignUpPage> createState() => signUp();

}


class signUp extends State<SignUpPage> {
  @override
  void deactivate() {
    super.deactivate();
    accountFlag = false;
    accountFlag= false;
  }

  @override
  void dispose() {
    super.dispose();
    accountFlag = false;
    accountFlag= false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              decoration:  BoxDecoration(
                color: Color.fromARGB(255,140,140,140),
              ),
            ),
            SafeArea(
              child: BackButton(onPressed: () => Navigator.pop(context, true),),
              top: true,
            ),
            if(!accountFlag)
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
                            Text("Accounts", style: TextStyle(fontSize: 32 , color: Colors.white)),
                            SizedBox(height: 40),
                            FractionallySizedBox(
                                widthFactor: 0.8,
                                child: Column(children: [
                                  const TextField(style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black),
                                      ),
                                        labelStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                        labelText: 'Username',
                                      )
                                  ),
                                  SizedBox(height: 10),
                                  const TextField(style: TextStyle(color: Colors.white),
                                      obscureText: true,
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                        ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black),
                                          ),
                                        labelStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                        labelText: 'Password',
                                      )
                                  ),
                                  SizedBox(height: 10),
                                  const TextField(style: TextStyle(color: Colors.white),
                                      obscureText: true,
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.black),
                                        ),
                                        labelStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                        labelText: 'Confirm Password',
                                      )
                                  ),
                                  SizedBox(height: 10),
                                  FractionallySizedBox(
                                      widthFactor: 1,
                                      child:
                                      OutlinedButton(
                                        onPressed: ()
                                        {
                                          setState(()
                                          {
                                            accountFlag = true;
                                          });
                                        },
                                        style: ButtonStyle(
                                          foregroundColor:  MaterialStateProperty.all(Colors.black),
                                          backgroundColor: MaterialStateProperty.all(Colors.white),
                                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
                                        ),
                                        child: const Text(
                                          "Continue" ,
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                      )
                                  ),

                                ],
                                )

                            ),

                          ]
                      ),
                    ),
                  ],
                )
            )
            else if(accountFlag && !nameFlag )
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
                              Text("My first name is", style: TextStyle(fontSize: 32 , color: Colors.white)),
                              SizedBox(height: 40),
                              FractionallySizedBox(
                                  widthFactor: 0.8,
                                  child: Column(children: [
                                    const TextField(style: TextStyle(color: Colors.white),
                                        decoration: InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black),
                                          ),
                                          labelStyle: TextStyle(
                                            color: Colors.white,
                                          ),
                                          labelText: 'First Name',
                                        )
                                    ),
                                    SizedBox(height: 10),
                                    FractionallySizedBox(
                                        widthFactor: 1,
                                        child:
                                        OutlinedButton(
                                          onPressed: ()
                                          {
                                            setState(()
                                            {
                                              accountFlag = true;
                                            });
                                          },
                                          style: ButtonStyle(
                                            foregroundColor:  MaterialStateProperty.all(Colors.black),
                                            backgroundColor: MaterialStateProperty.all(Colors.white),
                                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
                                          ),
                                          child: const Text(
                                            "Continue" ,
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                            ),),
                                        )
                                    ),

                                  ],
                                  )

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