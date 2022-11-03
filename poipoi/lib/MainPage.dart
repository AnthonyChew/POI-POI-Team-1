/*
HomePage:
First tab shown by default when users login successfully
Consists of a list of posts(or is it supposed to be just locations idk)
Still need to figure out how users gonna interact with the posts
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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


  _commentButtonPressed(Object postid) {
    setState(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CommentSection(postid: postid)));
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
                      stream: FirebaseFirestore.instance.collection('healthy_eatery').snapshots(),
                      builder:(context,snapshot){

                        if(snapshot.hasError){
                          return Text('Something went wrong');
                        }
                        if(!snapshot.hasData){
                          return Center(child: CircularProgressIndicator());
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
      onRatingUpdate: (rating) {

      },
    );
  }

  Widget _buildPostList(snapshot)=> ListView.builder(
      itemCount: snapshot.data?.docs.length,
      itemBuilder: (context, index) {
        List <QueryDocumentSnapshot> items = [];
        items = snapshot.data?.docs;
        items.sort((a,b) {
          if(sortByRatings){
            return b["rating"].compareTo(a["rating"]);
          }
          return a["NAME"].toLowerCase().compareTo(b["NAME"].toLowerCase());
        });
        QueryDocumentSnapshot<Object?>? documentSnapshot = items[index];
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
                                  flex : 1,
                                  child: const SizedBox(width: 10.0)
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(


                                  child: Text((documentSnapshot!=null) ? (documentSnapshot["NAME"] ): "",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white,
                                      fontSize: 25.0,
                                      fontFamily: 'NotoSans',
                                      fontWeight: FontWeight.bold,),
                                  ),
                                ),
                              ),

                              Expanded(
                                flex: 1,
                                child: SizedBox(
                                  width: 10.0,
                                  child: PopupMenuButton(
                                    icon: Icon(Icons.more_vert, color: Colors.white),
                                    iconSize: 32.0,
                                    color: Colors.white,
                                    itemBuilder: (context) => [
                                      PopupMenuItem<int>(
                                        value: 0,
                                        child: (documentSnapshot!=null) ?Text("Add to Favourites",style: TextStyle(color: Colors.black)) : Text(""),
                                      ),
                                      PopupMenuItem<int>(
                                        value: 1,
                                        child: sortByRatings? Text("Sort A-Z",style: TextStyle(color: Colors.black)): Text("Sort by Ratings",style: TextStyle(color: Colors.black)),
                                      ),


                                    ],

                                    onSelected: (item)
                                    async {
                                      switch(item){
                                        case 0://-------------------------------------------------> database need to update too to save for next login
                                            final docUser = FirebaseFirestore .instance .collection("user_data").doc(FirebaseAuth.instance.currentUser?.uid);
                                            DocumentSnapshot<Map<String, dynamic>> map = await FirebaseFirestore.instance.collection("user_data").doc(FirebaseAuth.instance.currentUser?.uid).get();
                                            final Map<String,dynamic> test= {"likeLocation" :[documentSnapshot.id]};
                                            final Map<String, dynamic>? map1 = map.data();
                                            if(!map1!.keys.contains("likeLocation"))
                                              {
                                                map1?.addAll(test);
                                              }
                                            else
                                              {
                                                 List<dynamic> likeLocation = map1["likeLocation"];
                                                 if(!likeLocation.contains(documentSnapshot.id))
                                                   {
                                                     likeLocation.add(documentSnapshot.id);
                                                   }
                                              }

                                            docUser.set(map1);

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
                          children:[
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
                                      posts[i],
                                      fit: BoxFit.cover,
                                    );
                                }


                                ),

                              ),),


                            Container(
                              padding: EdgeInsets.only(top: 8.0),
                              child: _ratingBar((documentSnapshot!=null)? ( documentSnapshot["rating"].toDouble()) : (0.0)),
                            )

                          ]
                      ),

                    ]
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                left: 5.0, right: 5.0, bottom: 2.0),

                            child: RoundedLoadingButton(
                              width: 60.0,
                              controller: _btnController1,
                              successIcon: Icons.pin_drop,
                              failedIcon: Icons.wrong_location,

                              child: Container(
                                margin: EdgeInsets.only(right: 5.0,),
                                padding: const EdgeInsets.fromLTRB(
                                    10.0, 2.0, 5.0, 5.0),
                                child: Row(
                                    children: [
                                      Icon(Icons.directions),
                                      Text('Directions',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'NotoSans',
                                            fontWeight: FontWeight
                                                .bold,)),
                                    ]
                                ),
                              ),

                              onPressed: () =>
                                  _doSomething(_btnController1),
                            ),
                          ),

                          RoundedLoadingButton(
                            width: 20.0,
                            controller: _btnController1,
                            successIcon: Icons.pin_drop,
                            failedIcon: Icons.wrong_location,
                            color: Colors.white,
                            valueColor: Colors.blue,
                            errorColor: Colors.white,
                            successColor: Colors.white,

                            child: Container(
                              margin: EdgeInsets.only(right: 5.0,),
                              padding: const EdgeInsets.fromLTRB(
                                  10.0, 2.0, 5.0, 5.0),

                              child: Row(
                                  children: [
                                    Icon(Icons.gps_fixed_outlined,
                                      color: Colors.blue,),
                                    Text('Start', style: TextStyle(
                                      color: Colors.blue,
                                      fontFamily: 'NotoSans',
                                      fontWeight: FontWeight.bold,)),
                                  ]
                              ),
                            ),

                            onPressed: () =>
                                _doSomething(_btnController1),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 10.0),
                      child: IconButton(
                        iconSize: 40.0,
                        onPressed: () {
                          setState(() {
                            // posts[index].setClick(true);
                            _commentButtonPressed((documentSnapshot!=null)? documentSnapshot.id : 0);
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
