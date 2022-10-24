import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'user.dart';
import 'user_preferences.dart';
import 'profile_widget.dart';
import 'textfield_widget.dart';
import 'button_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  User user = UserPreferences.myUser;

  @override
  Widget build(BuildContext context) {
    return Builder(
    builder: (context) =>Scaffold(
      appBar: AppBar(
        title: Text('EDIT ACCOUNT', style: TextStyle(fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'NotoSans',
          letterSpacing: 2.0,)),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Center(

        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 32),
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              margin: EdgeInsets.all(10),
            ),
            ProfileWidget(
              imagePath: user.imagePath,
              isEdit: true,
              onClicked: () async {
                final image = await ImagePicker().getImage(source: ImageSource.gallery);
                if (image == null) return;
                final directory  = await getApplicationDocumentsDirectory();
                final name = basename(image.path);
                final imageFile = File('${directory.path}/$name');
                final newImage =
                    await File(image.path).copy(imageFile.path);
                setState(() => user = user.copy(imagePath: newImage.path));
                },
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
              label: 'Full Name',
              text: user.name,
              onChanged: (name) {},
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
              label: 'Email',
              text: user.id,
              onChanged: (email) {},
            ),
            const SizedBox(height: 24),
            ButtonWidget(
              text: 'Save',
              onClicked:(){
              },
            ),
          ],
        ),
      ),
    ),
    );
  }

}