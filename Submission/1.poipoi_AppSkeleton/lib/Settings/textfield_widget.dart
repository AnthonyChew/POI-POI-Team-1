import 'package:flutter/material.dart';
class TextFieldWidget extends StatefulWidget {
  final String label;
  final String text;
  final ValueChanged<String> onChanged;

  const TextFieldWidget({
    Key?key,
    required this.label,
    required this.text,
    required this.onChanged,
}): super(key:key);
  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late final TextEditingController controller;
  @override
  void initState(){
    super.initState();

    controller= TextEditingController(text: widget.text);
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize:20, color: Colors.white),
        ),
        const SizedBox(height:8),
        TextField(
          style:TextStyle(color:Colors.white, fontSize:18),
          controller: controller,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width:3,
                color:Colors.white,
    ),
              borderRadius:BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}
