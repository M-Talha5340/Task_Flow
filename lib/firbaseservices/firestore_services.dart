import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_flow/models/task.dart';

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
                    {"name": name,"email":email,"profile-image":""}
                  );
    
  }

  Future<void> addTask(Task t )async{
            String id =  FirebaseAuth.instance.currentUser!.uid;
               final docRef= FirebaseFirestore.instance.collection("users").doc(id)
               .collection("tasks").doc();
                t.id = docRef.id;                
              await docRef.set(t.tomap());
  }

  Stream<List<Task>> viewTask(){         
         String id =  FirebaseAuth.instance.currentUser!.uid;
        return FirebaseFirestore.instance.collection("users").doc(id).collection("tasks").
        snapshots().map((snapshot){          
            return snapshot.docs.map((doc){
              return Task.frommap(doc.data());
            }).toList();
        });           
         
  } 

    Future<void> updateTask(String id,bool value) async{
              String uid = FirebaseAuth.instance.currentUser!.uid;
              await FirebaseFirestore.instance.collection("users").doc(uid).
              collection("tasks").doc(id).update({
                "completed": value
              });

       }
}