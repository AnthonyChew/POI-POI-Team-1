/*
HomePage:
First tab shown by default when users login successfully
Consists of a list of posts(or is it supposed to be just locations idk)
Still need to figure out how users gonna interact with the posts
 */
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'dart:async';
import 'dart:ui';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'Comment/CommentSection.dart';
class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {

  final RoundedLoadingButtonController _btnController1 = RoundedLoadingButtonController();
  void _doSomething(RoundedLoadingButtonController controller) async {
    Timer(Duration(seconds: 10), () {
      controller.success();
    });
  }
  late List posts = ['assets/images/pp1.JPG','assets/images/pp2.jpg','assets/images/pp1.JPG'];
  _commentButtonPressed(String postid) {
    setState(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) =>CommentSection(postid: postid)));
    });
  }
  bool sortByRatings = false;
  @override
  Widget build(BuildContext context) {

    return Container(
      child:
      Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                    alignment: Alignment.center,
                    image: AssetImage('assets/images/try.jpg',),
                    fit: BoxFit.cover,
                  )
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                child: Center(
                ),
              ),
            ),
            Flex(
                direction: Axis.vertical,
                children:[
                  Expanded(child:
                  StreamBuilder<QuerySnapshot>(
                      stream: (sortByRatings)?FirebaseFirestore.instance.collection("healthy_eatery").orderBy("rating",descending:true).snapshots(): FirebaseFirestore.instance.collection("healthy_eatery").orderBy("NAME").snapshots(),
                      builder:(context,snapshot){
                        // Map<dynamic,dynamic> data = null;
                        //  FirebaseFirestore.instance.collection('gymLocation').get().then((snapshot) async{
                        //    if(snapshot.docs.isNotEmpty)
                        //      {
                        //         data = snapshot.docs[0].data();
                        //      }
                        //  });
                        //
                        //  data["rating"] = 5.0;
                        if(!snapshot.hasData){
                          return Center( child: CircularProgressIndicator(),);
                        }
                        if(snapshot.hasError){
                          return Text('Something went wrong');
                        }
                        //else if(snapshot.hasData || snapshot.data!=null){
                        return _buildPostList(snapshot);
                        // }
                      }
                  ))]
            ),
          ]
      ),
    );
  }
  Widget _ratingBar(double rate) {
    return RatingBar.builder(
      initialRating: rate,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 0.5),
      itemBuilder: (context, _) =>
          Icon(
            Icons.star,
            color: Colors.amber,
            size: 1.0,
          ),
      ignoreGestures: true,
      onRatingUpdate: (rating) {},
    );
  }
  Widget _buildPostList(snapshot) {
    int countfood = 1;

    return ListView.builder(

        itemCount: snapshot.data?.docs.length,
        itemBuilder: (context, index) {
          List <QueryDocumentSnapshot> items = [];
          items = snapshot.data?.docs;
          // items.sort((a,b) {
          //   if(sortByRatings){
          //     return b["rating"].compareTo(a["rating"]);
          //   }
          //   return a["NAME"].toLowerCase().compareTo(b["NAME"].toLowerCase());
          // });
          QueryDocumentSnapshot<Object?> documentSnapshot = items[index];
          return Card(
            color: Colors.black.withOpacity(0.8),
            margin: EdgeInsets.symmetric(
              vertical: 10.0, horizontal: 10.0,),
            child: Column(
                children: [
                  Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: const SizedBox(width: 10.0)
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                    child: Text((documentSnapshot != null)
                                        ? (documentSnapshot["NAME"])
                                        : "",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    width: 10.0,
                                    child: PopupMenuButton(
                                      icon: Icon(
                                          Icons.more_vert, color: Colors.white),
                                      iconSize: 32.0,
                                      color: Colors.white,
                                      itemBuilder: (context) =>
                                      [
                                        PopupMenuItem<int>(
                                          value: 0,
                                          child: (documentSnapshot != null)
                                              ? Text("Add to Favourites",
                                              style: TextStyle(
                                                  color: Colors.black))
                                              : Text(""),
                                        ),
                                        PopupMenuItem<int>(
                                          value: 1,
                                          child: sortByRatings ? Text(
                                              "Sort A-Z", style: TextStyle(
                                              color: Colors.black)) : Text(
                                              "Sort by Ratings",
                                              style: TextStyle(
                                                  color: Colors.black)),
                                        ),
                                      ],
                                      onSelected: (item) {
                                        switch (item) {
                                          case 0:
                                            setState(() { //-------------------------------------------------> database need to update too to save for next login
                                              // (documentSnapshot!=null)? FirebaseFirestore.instance.collection('user_data').doc(user_id).update({'favourites': FieldValue.arrayUnion([documentSnapshot.id])}): "";
                                            });
                                            break;
                                          case 1:
                                            setState(() {
                                              sortByRatings = !sortByRatings;
                                            });
                                            break;
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ]
                          ),
                        ),
                        Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(
                                    0.0, 10.0, 0.0, 10.0),
                                child: ImageSlideshow(
                                  indicatorColor: Colors.white,
                                  // onPageChanged: (value) { debugPrint('Page changed: $value');},
                                  isLoop: false,
                                  children: List.generate(
                                      posts.length, (i) {
                                    return
                                      Image.asset(
                                        "assets/images/food${countfood++ % 15 +
                                            1}.jpg",
                                        fit: BoxFit.cover,
                                      );
                                  }
                                  ),
                                ),),
                              Container(
                                padding: EdgeInsets.only(top: 8.0),
                                child: _ratingBar((documentSnapshot != null)
                                    ? (documentSnapshot["rating"].toDouble())
                                    : (0.0)),
                              )
                            ]
                        ),
                      ]
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      Container(
                        padding: EdgeInsets.only(right: 10.0),
                        child: IconButton(
                          iconSize: 40.0,
                          onPressed: () {
                            setState(() {
                              _commentButtonPressed(
                                // print("+++++++++++++++++++++++++${snapshot.data.docs[index].id }");
                                  (snapshot.data.docs[index] != null) ? snapshot.data
                                      .docs[index].id : 0);
                            });
                          },
                          color: Colors.grey,
                          icon: Icon(Icons.chat_bubble_rounded),
                        ),
                      ),
                    ],
                  ),
                ]
            ),
          );
        }
    );
  }
}