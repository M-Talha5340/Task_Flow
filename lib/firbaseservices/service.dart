import 'package:firebase_auth/firebase_auth.dart';

class Service{
      
      Service ._();
      static final Service instance = Service._();
      final FirebaseAuth _auth = FirebaseAuth.instance;
     Future<UserCredential> signUp(String email, String password) async{
      try{
       return await _auth.createUserWithEmailAndPassword(email: email, password: password);
      }
      on FirebaseAuthException {
          rethrow;
      }
    }
    Future<UserCredential> signIn(String email, String password) async{
      try{
       return await _auth.signInWithEmailAndPassword(email: email, password: password);
      }
      on FirebaseAuthException {
          rethrow;
      }
    }
}