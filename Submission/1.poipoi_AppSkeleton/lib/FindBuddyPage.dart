/*
PlaceHolder for FindBuddyPage
 */

import 'package:flutter/material.dart';
import 'Screen2.dart';

class FindBuddyPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Center(
        child: IconButton(
          icon: Icon(Icons.people),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => Screen2()
            ));
          },

          color: Colors.white,
        ),
      ),
    );
  }
}