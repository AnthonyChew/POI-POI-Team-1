import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class ContactUsPage extends StatefulWidget {

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) =>Scaffold(
        appBar: AppBar(
        title: Text('CONTACT US', style: TextStyle(fontSize: 20,
      fontWeight: FontWeight.bold,
      fontFamily: 'NotoSans',
      letterSpacing: 2.0,)),
    centerTitle: true,
    backgroundColor: Colors.black,
    ),
    backgroundColor: Colors.black,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children:[
        SizedBox(height:25),
        Container(
      color:Colors.transparent,
        alignment: Alignment.center,
        padding:EdgeInsets.all(25),
        child:Text('We will be in touch shortly!',
      style: TextStyle(fontSize: 36,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        ),),),
        SizedBox(height:40),
      Container(
        margin: EdgeInsets.all(15),
      child:ElevatedButton.icon(
        onPressed:() async {
          Uri phoneno = Uri.parse('tel:+6581234568');
          if (await launchUrl(phoneno)){
        } else { throw 'Error occurred trying to call that number.';
    }},
        icon: const Icon(Icons.phone),
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          padding: EdgeInsets.all(20),
        ),
        label:Text('Telephone: +65 6123 4568',
        style: TextStyle(fontSize:20),),
        ),),
          Container(
            margin: EdgeInsets.all(15),
        child: ElevatedButton.icon(
          onPressed:() async {Uri sms = Uri.parse('sms:+6581234568?body=your+text+here');
          if (await launchUrl(sms)){
          } else { throw 'Error occurred trying to message that number.';
          }},
          icon: const Icon(Icons.whatsapp),
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            padding: EdgeInsets.all(20),
          ),
          label:Text('Message: +65 8123 4568',style: TextStyle(fontSize:20),),
        ),),
          Container(
            margin: EdgeInsets.all(15),
        child:ElevatedButton.icon(
          onPressed:() async {
            Uri email=Uri(scheme: 'mailto',path:'CustomerService@poipoi.org');
            if (await launchUrl(email)){
          } else { throw 'Error occurred trying to send an email.';}},
          icon: const Icon(Icons.email),
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            padding: EdgeInsets.all(20),
          ),
          label:Text('Email: CustomerService@poipoi.org',style: TextStyle(fontSize:16),),
        ),),
      ],
    ),
    ),
        );
  }
}
