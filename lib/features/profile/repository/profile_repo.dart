
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:property_managment/core/constant/firebase_const.dart';
import 'package:property_managment/modelClass/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepository {
  final FirebaseService service;
  ProfileRepository(this.service);

  Stream<UserModel?> getUserData(String userId) {
      
    return service.users.doc(userId).snapshots().map((doc){
      if (!doc.exists) return null;
      log("ssssssssssssssss ");
      return UserModel.fromMap(doc.data()as Map<String, dynamic>, doc.id);
    });
  }

  
Future<void> saveUserData(Map<String,dynamic> user) async{
    await service.users.doc(user['ID']).set(user,SetOptions(merge: true));
  }
   
}



