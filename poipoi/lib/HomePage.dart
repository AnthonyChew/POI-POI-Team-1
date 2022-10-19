/*
HomePage:
First tab shown by default when users login successfully
Consists of a list of posts(or is it supposed to be just locations idk)
Still need to figure out how users gonna interact with the posts
 */

import 'package:flutter/material.dart';
import 'post.dart';
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
    Post(title: 'Punggol Park', description: 'Fun day at the park!!', username: 'Peter', imageURL: ['assets/images/pp1.JPG', 'assets/images/pp2.jpg', 'assets/images/pp1.JPG'] ),

    Post(title: 'Woodlands Park', description: 'Fun day at the park!!', username: 'Peter', imageURL: ['assets/images/pp1.JPG', 'assets/images/pp2.jpg'] ),
  ];



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
                                Text(
                                  'Posted by ${posts[index].username}',
                                  style: TextStyle(fontSize: 10.0, fontFamily: 'NotoSans',),
                                ),
                                Text(
                                  posts[index]. description,
                                  style: TextStyle(fontSize:12.0, fontFamily: 'NotoSans', letterSpacing:2.0, ),
                                  textAlign: TextAlign.end,

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
                            Container(

                              padding: const EdgeInsets.fromLTRB(2.0,10.0,250.0,10.0),
                              child: RoundedLoadingButton(
                                controller:_btnController1,
                                successIcon: Icons.pin_drop,
                                failedIcon: Icons.wrong_location,

                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(10.0,2.0,5.0,2.0),
                                  child: Row(
                                      children: [
                                        Icon( Icons.directions),
                                        Text('Get Directions!', style: TextStyle(color: Colors.white)),
                                      ]
                                  ),
                                ),

                                onPressed: () => _doSomething(_btnController1),
                              ),
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
