/*
HomePage:
First tab shown by default when users login successfully
Consists of a list of posts(or is it supposed to be just locations idk)
Still need to figure out how users gonna interact with the posts
 */

import 'package:flutter/material.dart';
import 'Post.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'dart:async';
import 'dart:ui';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';




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

  //hardcode.. need to edit later on..
  //gets a list of posts
  List<Post> posts = [
    Post(title: 'Punggol Park', imageURL: ['assets/images/pp1.JPG', 'assets/images/pp2.jpg', 'assets/images/pp1.JPG'] ),

    Post(title: 'Woodlands Park', imageURL: ['assets/images/pp1.JPG', 'assets/images/pp2.jpg'] ),
  ];

_commentButtonPressed(int index){
  setState(() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => posts[index].page));
  });
}

  @override
  Widget build(BuildContext context) {
    return Container(
    child:
      Stack(
          children:[
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




            // only for Home Page!!
            ListView.builder(
                itemCount: posts.length,
                itemBuilder:(context, index){
                  return Card(
                      elevation: 20.0,
                      shadowColor: Colors.white,
                      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0,),
                      child: Column(
                          children:[
                            Column(
                              children: [
                                Text(
                                  posts[index].title,
                                  style: TextStyle(fontSize:20.0, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                                ),

                              ],
                            ),


                            Container(
                                padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                                child: ImageSlideshow(
                                  indicatorColor: Colors.blue,
                                 // onPageChanged: (value) { debugPrint('Page changed: $value');},
                                  isLoop: false,
                                  children: List.generate(
                                      posts[index].imageURL.length, (i)
                                            {
                                              return Image.asset(
                                                posts[index].imageURL[i],
                                                fit: BoxFit.cover,
                                              );

                                            }


                                ),

                            ),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(

                                  padding: const EdgeInsets.fromLTRB(5.0,10.0,20.0,10.0),
                                  child: RoundedLoadingButton(
                                    width: 50.0,
                                    controller:_btnController1,
                                    successIcon: Icons.pin_drop,
                                    failedIcon: Icons.wrong_location,

                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(10.0,2.0,5.0,2.0),
                                      child: Row(
                                          children: [
                                            Icon( Icons.directions),
                                            Text('Directions!', style: TextStyle(color: Colors.white)),
                                          ]
                                      ),
                                    ),

                                    onPressed: () => _doSomething(_btnController1),
                                  ),
                                ),

                                Container(
                                  padding: EdgeInsets.only(right:5.0),
                                  child: IconButton(
                                      iconSize : 40.0,
                                      onPressed: () {
                                        setState(() {
                                          posts[index].setClick(true);
                                          _commentButtonPressed(index);
                                        });
                                      },
                                      color: Colors.blue,
                                      icon: Icon( Icons.chat_bubble_outline_rounded ),
                                ),
                                ),
                              ],
                            ),


                          ]

                      ),
                  );
                }



            ),

          ]

      ),





    );
  }
}
