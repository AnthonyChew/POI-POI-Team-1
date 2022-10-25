import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final bool isEdit;
  final VoidCallback onClicked;
  const ProfileWidget({
    Key? key,
    required this.imagePath,
    this.isEdit = false,
    required this.onClicked,
}) : super(key:key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Align(
        alignment: isEdit ? FractionalOffset.topCenter: FractionalOffset.topLeft,
        child:Stack(
      children:[
      isEdit? buildEditImage():buildImage(),
      Positioned(
        bottom:0,
        right:1.0,
        child:buildEditIcon(),),
      ],),),
    );
}

Widget buildEditImage(){
  final image= imagePath.contains('https://')
      ? NetworkImage(imagePath): FileImage(File(imagePath));
  return Container(
    child: InkWell(onTap: onClicked),
    height:135,
    width:145,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: image as ImageProvider,
        fit: BoxFit.fill,
      ),
      shape: BoxShape.circle,
      // borderRadius: BorderRadius.circular(60.0),

    ),
  );
}

Widget buildImage(){
    final image= imagePath.contains('https://')
      ? NetworkImage(imagePath): FileImage(File(imagePath));
    return Container(
      child: InkWell(onTap: onClicked),
      height:130,
      width:125,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: image as ImageProvider,
          fit: BoxFit.fill,
        ),
        shape: BoxShape.circle,
        // borderRadius: BorderRadius.circular(60.0),

      ),
  );
  }
  Widget buildEditIcon() => buildCircle(
    color: Colors.white,
    all:3,
    child: buildCircle(
      color: Colors.black,
      all:6,
      child:Icon(
      isEdit ? Icons.add_a_photo:Icons.edit,
      color: Colors.white,
      size:18,
      ),),
  );


Widget buildCircle({
  required Widget child,
  required double all,
  required Color color,}) =>
    ClipOval(
    child:Container(
      padding: EdgeInsets.all(all),
      color: color,
      child: child,
    ));
}

