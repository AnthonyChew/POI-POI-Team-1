import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Comment.dart';

void main() {
  runApp(const CommentSection());
}


class CommentSection extends StatefulWidget {
  const CommentSection({Key? key}) : super(key: key);



  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {

  List<Comment> _comments = [Comment(comment: 'hello people', dateTimePosted: '2022-05-2'), Comment(comment:'nihaooooooooooooooooooooooooo\nooooooooo\noooooooooooooooooooooooo', dateTimePosted: '222222')];

  void _addComment(Comment val){
    setState(() {
      _comments.add(val);
    });
  }


  Widget _buildCommentList() {
    return ListView.builder(
        itemBuilder: (context, index){
          if(index < _comments.length){
            return _buildCommentItem(_comments[index]);
          }
          throw NullThrownError();
        }
        );
  }

  Widget _buildCommentItem(Comment comment){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Card(
        elevation: 5.0,
        child: Column(
          children: [
            ListTile(
              leading: Image.asset('assets/images/logo.png'),
              title: Text('Peter'), //need username
            subtitle: Text('Posted on ${comment.dateTimePosted}'),
          ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0,),
              child: Align(
               alignment: Alignment.centerLeft,
                child: Text(
                    comment.comment,
                ),
              ),
            ),
        ]
        ),
      ),
    );
  }

  // bool submit = false;
   TextEditingController _controller = TextEditingController();
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _controller.addListener(() {
  //     setState(() {
  //       submit = _controller.text.isNotEmpty;
  //     });
  //   });
  // }
  // // void setValidator(valid){
  // //   setState(() {
  // //     empty = valid;
  // //   });
  // // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comments"),
        centerTitle: true,
        backgroundColor: Colors.black,
        toolbarOpacity: 0.7,
      ),

      body:
      Stack(
        children: [

        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.center,
                image: AssetImage('assets/images/try.jpg', ),
                fit: BoxFit.cover,
              )
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Center(

            ),
          ),
        ),



          Column(children: <Widget> [Expanded(child: _buildCommentList()),

        SizedBox(
          width: 380,
          child: TextField(
            controller: _controller,

            textInputAction: TextInputAction.go,
            onChanged:(String text){
              setState(() {
                _submitted = false;
              });
            },
            onSubmitted: (String submit){
              setState(() {
                _submitted = true;
              });
              if(_errorText == null) {
                DateTime now = DateTime.now();
                String dateTime = DateFormat('dd-MM-yyyy kk:mm').format(now);
                _addComment(Comment(comment: submit, dateTimePosted: dateTime));
                _controller.clear(); //username, and pic
                setState(() {
                  _submitted = false;

                });
              }



            },
            autocorrect: true,


            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500,),
            maxLines: 2,

            decoration: InputDecoration(

              contentPadding: const EdgeInsets.all(10.0),
              hintText: '...',
              hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, ),
              labelText: 'Write a comment...',
              labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, ),
                errorText: _submitted ? _errorText : null,
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color:Colors.red,)),
              suffixIcon: IconButton(
                icon:Icon(Icons.clear),
                onPressed: () => _controller.clear()
              ),



            ),

            ),
        ),
         ]
        ),
    ]
    ),
    );




  }

  bool _submitted = false;

  String? get _errorText {
    final text = _controller.value.text;

    if (text.isEmpty) {
      return 'Empty field';
    }
    // return null if the text is valid
    return null;
  }
}
