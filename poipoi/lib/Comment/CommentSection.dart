import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Comment.dart';
import 'package:poipoi/Model/GlobalData.dart' as gbdata;
import 'package:cloud_firestore/cloud_firestore.dart';

//left need get user profile pic and how to rebuild builder??

class CommentSection extends StatefulWidget {
  const CommentSection({Key? key, required this.postid}) : super(key: key);
  final String postid;

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  //_CommentSectionState();
  late Future<List<Comment>> _commentsList;

  @override
  void initState() {
    super.initState();
    _commentsList = getList();
  }

  void _addComment(Comment val) {
    //print("\n\n++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n\n");
    CollectionReference docRef = FirebaseFirestore.instance
        .collection("comments")
        .doc(widget.postid + "comment")
        .collection("1");
    // print("\n\n-----------------------------------" + postid +"----------------------------------\n\n");

    //DocumentReference docRef1 = FirebaseFirestore.instance.collection("healthy_eatery").doc(postid);
    Map<String, String> comments = {
      "username": val.username,
      "comments": val.comment,
      "datetime": val.dateTimePosted,
    };
    docRef.add(comments);
    //getList();
    //
    //   //FirebaseFirestore.instance.collection("healthy_eatery").doc(postid).set({"comments": '/comments/${postid + "comment"}' });
    //   // setState(() {
    //   //   _comments.add(val);
    //   // });
  }

  Future<List<Comment>> getList() async {
    List<Comment> commentsList = [];
    Map<dynamic, dynamic> mdata = new Map<dynamic, dynamic>();
    // await Future.delayed(Duration(seconds: 3));

    var snapshot =
        await FirebaseFirestore.instance.collection("healthy_eatery").get();

    if (snapshot.docs.isNotEmpty) {
      for (int i = 0; i < snapshot.docs.length; i++) {
        Map<dynamic, dynamic> map = snapshot.docs[i].data();
        if (map.keys.contains("comments")) {
          DocumentReference<Map<dynamic, dynamic>> map1 = map["comments"];
          //print("${widget.postid}comment");
          if (map1.id != "${widget.postid}comment") continue;
          print("++++++++++++++++ ${map1.id}");

          var snapshot =
              await FirebaseFirestore.instance.collection("comments").get();

          //    print("++++++++++++++++ ${snapshot.docs.length}");
          for (int i = 0; i < snapshot.docs.length; i++) {
            if (snapshot.docs[i].id == map1.id) {
              //    print("++++++++++++++++ ${snapshot.docs[i].id}");

              var test = await FirebaseFirestore.instance
                  .collection("comments")
                  .doc(map1.id)
                  .collection("1")
                  .get();
              var data = await test.docs;

              for (int i = 0; i < data.length; i++) {
                mdata = data[i].data();
                print("Comemnts :" +
                    mdata['comments'] +
                    " Testdata:" +
                    mdata['datetime']);

                commentsList.add(Comment(
                    username: gbdata.user_data.getName,
                    comment: mdata['comments'],
                    dateTimePosted: mdata['datetime']));
              }
            }
          }
        }
      }
    }

    return Future.value(commentsList);
  }

  Widget _buildCommentList() {
    return StreamBuilder<List<Comment>>(
      stream: Stream.fromFuture(getList()),
      //dk how rebuild and order or use _commentsList but this doesnt rebuild unless refresh page; but getList() will keep refreshing

      builder: (ctx, snapshot) {
        // if (!snapshot.hasData) {
        //   return Container(
        //     child: Center(
        //       child: CircularProgressIndicator(),
        //     ),
        //   );
        // }
        //List<Comment> comments = snapshot.data;
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return _buildListView(snapshot);
          default:
            return _buildLoadingScreen();
        }
      },
    );
  }

  Widget _buildListView(AsyncSnapshot<List<Comment>> snapshot) {
    return ListView.builder(
      itemBuilder: (ctx, idx) {
        return _buildCommentItem(snapshot.data![idx]);
      },
      itemCount: snapshot.data!.length,
    );
  }

  Widget _buildLoadingScreen() {
    return Center(
      child: Container(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildCommentItem(comment) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Card(
        elevation: 5.0,
        child: Column(children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: FileImage(gbdata.user_data.getFile),
            ),
            title: Text(comment.username), //need username
            subtitle: Text('Posted on ${comment.dateTimePosted}'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 10.0,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                comment.comment,
              ),
            ),
          ),
        ]),
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
    //postid = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text("COMMENTS",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'NotoSans',
              letterSpacing: 2.0,
            )),
        centerTitle: true,
        backgroundColor: Colors.black,
        toolbarOpacity: 0.7,
      ),
      body: Stack(children: [
        Container(
          padding: EdgeInsets.only(
            left: 5.0,
          ),
          decoration: const BoxDecoration(
              image: DecorationImage(
            alignment: Alignment.center,
            image: AssetImage(
              'assets/images/try.jpg',
            ),
            fit: BoxFit.cover,
          )),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Center(),
          ),
        ),
        Column(children: <Widget>[
          Expanded(child: _buildCommentList()),
          SizedBox(
            width: 380,
            child: TextField(
              controller: _controller,
              textInputAction: TextInputAction.go,
              onChanged: (String text) {
                setState(() {
                  _submitted = false;
                });
              },
              onSubmitted: (String submit) {
                setState(() {
                  _submitted = true;
                });
                if (_errorText == null) {
                  DateTime now = DateTime.now();
                  String dateTime = DateFormat('dd-MM-yyyy kk:mm').format(now);
                  print("\n\n==============+_+_+_+_+_+_+_++_++_+_+_+_+_=\n\n");
                  _addComment(Comment(
                      username: 'Peter',
                      comment: submit,
                      dateTimePosted: dateTime));
                  print("\n\n==============+_+_+_+_+_+_+_++_++_+_+_+_+_=\n\n");
                  _controller.clear(); //username, and pic
                  setState(() {
                    _submitted = false;
                  });
                }
              },
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                contentPadding: const EdgeInsets.all(10.0),
                hintText: '...',
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
                labelText: 'Write a comment...',
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                errorText: _submitted ? _errorText : null,
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.red,
                )),
                suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () => _controller.clear()),
              ),
            ),
          ),
        ]),
      ]),
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
