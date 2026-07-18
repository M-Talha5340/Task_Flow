import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_flow/firbaseservices/firestore_services.dart';
import 'package:task_flow/models/task.dart';

enum TaskFilter {
  all,
  pending,
  completed,
  highPriority,
}

class Taskprovider extends ChangeNotifier {
  final List<Task> _tasks = [];
  

  List<Task> get tasks => List.unmodifiable(_tasks);
  
  bool _isLoading = false;
  bool _isSaving = false;

  TaskFilter _filter = TaskFilter.all;

  TaskFilter get filter => _filter;

  List<Task> get filteredTasks {
  switch (_filter) {
    case TaskFilter.all:
      return List.unmodifiable(_tasks);

    case TaskFilter.pending:
      return _tasks.where((t) => !t.completed).toList();

    case TaskFilter.completed:
      return _tasks.where((t) => t.completed).toList();

    case TaskFilter.highPriority:
      return _tasks.where((t) => t.priority == "HIGH").toList();
  }
}

  bool get isSaving => _isSaving;  
  bool get isLoading => _isLoading;

  

  Future<void> loadTasks() async {
  
    try {
      _isLoading = true;          
      final tasks = await FirestoreServices.instance.getTask();
      _tasks.clear();
      _tasks.addAll(tasks);      
    } catch (e) {
      throw Exception( "Failed to Load Tasks");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addTask(Task task) async {
    if (_isSaving) {
      return;
    }
    try {
      _isSaving = true;      
      notifyListeners();
      await FirestoreServices.instance.addTask(task);
      _tasks.add(task);
    } catch (e) {
      throw Exception( "Failed Save Task");
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }

  Future<void> updateTask(Task task) async {
    if (_isSaving) {
      return;
    }
    try {
      _isSaving = true;      
    
      final index = _tasks.indexWhere((t) => t.id == task.id);
      if (index == -1) {
        return;
      }
      await FirestoreServices.instance.updateTask(task);
      _tasks[index] = task;
    } catch (e) {
      throw Exception( "Failed to Update Task");
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }
   
  Task getTaskById(String id){
    return  _tasks.firstWhere((t)=>t.id == id);
  }
  Future<void> deleteTask(Task task) async {
    if (_isSaving) {
      return;
    }
    try {
      _isSaving = true;    
    

      await FirestoreServices.instance.deleteTask(task);
      _tasks.removeWhere((t) => t.id == task.id);
    } catch (e) {
       throw Exception( "Failed to Delete Task");
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }

  void clear() {
    _tasks.clear();    
    notifyListeners();
  }

  void chandeFilter (TaskFilter newFilter){
       if(_filter == newFilter){
        return;
       }
       _filter = newFilter;
       notifyListeners();
  }

  List<Task> tasksForDay(DateTime day){
      return _tasks.where((t)=> isSameDay(t.date, day)).toList();
  }
}
