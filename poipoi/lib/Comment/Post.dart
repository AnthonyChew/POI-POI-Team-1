import 'CommentSection.dart';

class Post {

  String title;
  List<String> imageURL;
  bool click = false;
  //CommentSection page = CommentSection();

  double ratings;
  bool liked;
  Post({required this.title,  required this.imageURL, required this.ratings, required this.liked});



  void setClick(bool press){ click = press;}//???????????????
}