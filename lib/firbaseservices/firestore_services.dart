import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart'as storage;
import 'package:task_flow/models/task.dart';
import 'package:task_flow/models/user.dart';

class FirestoreServices {

    FirestoreServices._();

   static final  FirestoreServices instance = FirestoreServices._();
   static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

   Future<void> createUser({
    required String uid,
    required String name,
    required String email,
  })async{
             await _firestore.collection("users").doc(
                  uid).set(
                    {"name": name,"email":email,"profileimg":null}
                  );
    
  }

   Future<String> uploadProfileImage(File file) async {
  String uid = FirebaseAuth.instance.currentUser!.uid;

  final ref = storage.FirebaseStorage.instance
      .ref()
      .child("profileimages")
      .child("$uid.jpg");

  await ref.putFile(file);

  return await ref.getDownloadURL();
}

   Future<void> updateUser(AppUser user)async{
    String uid = FirebaseAuth.instance.currentUser!.uid;
             await _firestore.collection("users").doc(
                  uid).update(user.tomap());
    
  }
   Future<void> deleteUser()async{
     String uid = FirebaseAuth.instance.currentUser!.uid;
             await _firestore.collection("users").doc(
                  uid).delete();
    
  }

   Future<AppUser?> getUser()async{
            if(FirebaseAuth.instance.currentUser != null){
          String uid = FirebaseAuth.instance.currentUser!.uid;
          final querySnapshot=   await FirebaseFirestore.instance.collection("users").doc(uid).get();             
            return AppUser.fromMap(querySnapshot.data()!);
            }
            return null ;
                   
  }

  Future<void> addTask(Task task)async{ 
              String id =  FirebaseAuth.instance.currentUser!.uid;
               final docRef= FirebaseFirestore.instance.collection("users").doc(id)
               .collection("tasks").doc();  
               task.id = docRef.id;                         
              await docRef.set(task.tomap());
  }


  Future<List<Task>> getTask()async{
    String id =  FirebaseAuth.instance.currentUser!.uid;
     QuerySnapshot querySnapshot=   await FirebaseFirestore.instance.collection("users").
     doc(id).collection("tasks").get();
      
    return querySnapshot.docs.map((doc)=> Task.frommap(doc.data() as Map<String,dynamic>)).toList();
  }

    Future<void> updateTask(Task task) async{
              String uid = FirebaseAuth.instance.currentUser!.uid;
              await FirebaseFirestore.instance.collection("users").doc(uid).
              collection("tasks").doc(task.id).update(task.tomap());

       }
       Future<void> deleteTask(Task task) async{
              String uid = FirebaseAuth.instance.currentUser!.uid;
              await FirebaseFirestore.instance.collection("users").doc(uid).
              collection("tasks").doc(task.id).delete();

       }
       
}