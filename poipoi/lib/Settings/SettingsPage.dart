
import 'package:flutter/material.dart';
import 'MyUser.dart';
import 'profile_widget.dart';
import 'EditProfilePage.dart';
import 'change_password_page.dart';
import 'contact_us_page.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<Settings> createState() => _SettingsState();

}

class _SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as MyUser;
    return Scaffold(
        appBar: AppBar(
        title: Text('SETTINGS', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'NotoSans',letterSpacing:2.0,)),
    centerTitle: true,
    backgroundColor: Colors.black,
    ),
      backgroundColor: Colors.black,
      body: Column(
        children:[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
        Text('      Account',
        style: TextStyle(
          fontSize: 22.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
          ),
      new Container(
      //color: Colors.grey[300],
      height: 120,
        width: double.infinity,
        margin: const EdgeInsets.all(20),
        child:Padding(
          padding: const EdgeInsets.all(15),
          child: Stack(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Row(
              children:[ProfileWidget(
                imagePath: user.imagePath.path,
                onClicked: () {
                  Navigator.pushNamed(
                      context,
                      '/editProfile',
                      arguments: user);
                },

              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Padding(
                padding:EdgeInsets.only(left:0, bottom:5, right:20,top:15),
                child:Text(user.name,
              style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),),
                ),
                Padding(
                  padding:EdgeInsets.only(left:0, bottom:5, right:10,top:2),
                  child:Text(user.id,
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),),),

              ],
              ),

              ],
              ),
            ],),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow:[
            BoxShadow(
              color: Colors.grey,
              blurRadius:10,
              offset: Offset(4,8),
            ),
          ],
        ),
      ),
          Text('      Privacy',
            style: TextStyle(
              fontSize: 22.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          InkWell(
            onTap:(){Navigator.of(context).push(
              MaterialPageRoute(builder: (context)=>ChangePasswordPage()),
            );},
            child:Container(
            //color: Colors.grey[300],
            height: 70,
            width: double.infinity,
            margin: const EdgeInsets.only(left:20,top:20.0,right:20.0,bottom:10.0),
            child:Padding(
              padding: const EdgeInsets.all(20),
              child: Text('Change Password',
                style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow:[
                BoxShadow(
                  color: Colors.grey,
                  blurRadius:10,
                  offset: Offset(4,8),
                ),
              ],
            ),
          ),),
          new InkWell(
            //color: Colors.grey[300],
            onTap: (){print("Tapped");},
            splashColor:Colors.white,
            child:Container(
            height: 70,
            width: double.infinity,
            margin: const EdgeInsets.only(left:20,top:0.0,right:20.0,bottom:20.0),
              child: Row(
              children:[
              Padding(
              padding: const EdgeInsets.all(20),
              child: Text('Push Notifications',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),),),
              Icon(Icons.circle_notifications,color:Colors.black,size:35.0),],),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow:[
                BoxShadow(
                  color: Colors.grey,
                  blurRadius:10,
                  offset: Offset(4,8),
                ),
              ],
            ),
          ),
          ),
          Text('      Get Help',
            style: TextStyle(
              fontSize: 22.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          InkWell(
            onTap:(){Navigator.of(context).push(
              MaterialPageRoute(builder: (context)=>ContactUsPage()),
            );},
          child:Container(
            //color: Colors.grey[300],
            height: 70,
            width: double.infinity,
            margin: const EdgeInsets.only(left:20,top:20.0,right:20.0,bottom:10.0),
            child:Padding(
              padding: const EdgeInsets.all(20),
              child: Text('Contact Us',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),),),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow:[
                BoxShadow(
                  color: Colors.grey,
                  blurRadius:10,
                  offset: Offset(4,8),
                ),
              ],
            ),
          ),
          ),
                    ],
                  ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                height:70,
                width: double.infinity,
                margin: const EdgeInsets.only(left:20,top:20.0,right:20.0,bottom:10.0),
                //color: Colors.grey,
                child:Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('Sign Out',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,

                    ),
                    textAlign: TextAlign.center,
                  ),),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(15.0),

                ),
              ),
            ),
          ),
                ],
            ),


    );



  }
}

