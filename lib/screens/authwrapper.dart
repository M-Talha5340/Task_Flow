import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_flow/screens/navbar.dart';
import 'package:task_flow/screens/signin.dart';

class Authwrapper extends StatelessWidget {
  const Authwrapper({super.key});
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(), 
    builder: (context,snapshot){
       if(snapshot.connectionState == ConnectionState.waiting){
        return Scaffold(
             backgroundColor: const Color(0xffF7F8FC),
             body: Center(
              child: CircularProgressIndicator(color: const Color(0xff0D47A1),),
             ),
        );

       }
       if(snapshot.hasData){
           return Navbar();
       }
       return Signin();
    });
  }
}