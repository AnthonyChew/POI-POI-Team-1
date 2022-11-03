import 'CommentSection.dart';

class Post {

  String title;
  List<String> imageURL;
  bool click = false;
  CommentSection page = CommentSection();
  int rating = 0; //retrieve from database

  Post({required this.title,  required this.imageURL, });

  void setClick(bool press){ click = press;}
}