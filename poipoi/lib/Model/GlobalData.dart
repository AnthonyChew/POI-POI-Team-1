import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

import '../Cards/location.dart';
import '../Settings/MyUser.dart';

FirebaseAuth auth = FirebaseAuth.instance;
String? uuid = '';
List<Map> healthyEateryDate = [];
List<Map> parkDate = [];
late  Position position;
List<MyLocation> locations=[];
late MyUser user_data;