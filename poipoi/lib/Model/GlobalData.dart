import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

FirebaseAuth auth = FirebaseAuth.instance;
String? uuid = '';
List<Map> healthyEateryDate = [];
List<Map> parkDate = [];
late final Position position;