import 'dart:io';

import 'package:flutter/material.dart';
import 'package:task_flow/firbaseservices/firestore_services.dart';
import 'package:task_flow/models/user.dart';

class Userprovider extends ChangeNotifier{
    AppUser? _user;   
  AppUser? get user => _user;
  

  Future<void> setUser()async {
    try{
    final user = await FirestoreServices.instance.getUser();
    _user = user; 

    
    }catch(e){      
      rethrow;
    }
    finally{
      notifyListeners();
    }       
  }
  
  Future<void> updateUser(AppUser user) async {
        
    try {
    
     
      await FirestoreServices.instance.updateUser(user);
      _user = user;
      
    } catch (e) {
      throw Exception( "Failed to Update User");
    } finally {      
      notifyListeners();
    }
  }

  Future<String> uploadProfileImage(File file)async{
     try{        
        String url = await FirestoreServices.instance.uploadProfileImage(file);
        return url;
     }
     catch(e){
       rethrow;
     }

  }
  void clearUser() {
    _user = null;           
    
  }
}