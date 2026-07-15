import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
   String? id;
   String title;
   String description;
   DateTime date;
   String priority;
   bool completed;

  Task({
    required this.title,
    required this.description,
    required this.date,
    required this.priority,
    required this.completed,
    this.id
  });

     Map<String,dynamic> tomap(){
            return {
                 "id":id,
                "title":title,
                 "description": description,
                 "date":date,
                 "priority":priority,
                 "completed":completed
            };
    }

    factory Task.frommap(Map<String ,dynamic> map){
              return Task(
                id: map["id"],
                title: map["title"],
                description: map["description"],
                date:  (map["date"] as Timestamp).toDate(),
                priority: map["priority"],
                completed: map["completed"]
              );
    }
}
