import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
   String? id;
   final String title;
   final String description;
   final DateTime date;
   final String priority;
   final bool completed;

  Task({
    required this.title,
    required this.description,
    required this.date,
    required this.priority,
    required this.completed,
    this.id
  });

   Task copyWith({
    String ?title,
    String ?description,
    DateTime ?date,
    String ?priority,
    bool ?completed,
    String ?id
  }){
    return Task( id: id??this.id,  title: title ?? this.title, description: description ??this.description,
     date: date??this.date, priority: priority??this.priority, completed: completed??this.completed);
  }

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
