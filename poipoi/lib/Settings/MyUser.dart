import 'dart:async';
import 'dart:io';

class MyUser {
  late String id ; //email
  late String name;
  late String birthday;
  late bool is_male;
  late File imagePath;

  MyUser (this.id,this.name, this.birthday, this.is_male, this.imagePath);

}
