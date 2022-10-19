import 'CommentSection.dart';

class Post {

  String title;
  List<String> imageURL;
  bool click = false;
  CommentSection page = CommentSection();

  Post({required this.title,  required this.imageURL, });

  void setClick(bool press){ click = press;}
}