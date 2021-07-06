import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // ignore: unused_field

  String getUserId() {
    return _firebaseAuth.currentUser.uid;
  }
  String getId() {
    return (_firebaseAuth.currentUser).toString();
  }
}
