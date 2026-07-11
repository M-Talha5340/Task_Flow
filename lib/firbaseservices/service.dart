import 'package:firebase_auth/firebase_auth.dart';

class Service{
    static  final FirebaseAuth _auth = FirebaseAuth.instance;
    static Future<UserCredential> signUp(String email, String password) async{
      try{
       return await _auth.createUserWithEmailAndPassword(email: email, password: password);
      }
      on FirebaseAuthException {
          rethrow;
      }
    }
}