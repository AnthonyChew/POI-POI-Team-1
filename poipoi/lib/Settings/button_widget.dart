import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        onPrimary: Colors.white,
        padding: EdgeInsets.symmetric(horizontal:32,vertical:12),
      ),
      child: Text(text,
      style: TextStyle(
        fontWeight: FontWeight.bold, fontSize:20,
      )),
      onPressed: onClicked,
    );
  }
}
