// import 'package:property_managment/core/constant/firebase_const.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:property_managment/modelClass/user_model.dart';

// class ProfileRepository {
//   final FirebaseService  service;
//   ProfileRepository(this.service);
  

//   // Get user data
//   Stream<UserModel?> getUserData() async* {
//     final prefs = await SharedPreferences.getInstance();

//     final id = prefs.getString("userId");
//     final name = prefs.getString("name");
//     final email = prefs.getString("email");
//     final role = prefs.getString("role");
//     final password = prefs.getString("password");

//     if (id == null) {
//       yield null;
//     }else {
//       yield UserModel(id, name ?? "", email ?? "", role ?? "", password ?? "");
//     }
//   }

//   // Save user data
//   Future<void> saveUserData(UserModel user) async {
//     final prefs = await SharedPreferences.getInstance();

//     await prefs.setString("userId", user.id);
//     await prefs.setString("name", user.name);
//     await prefs.setString("email", user.email);
//     await prefs.setString("role", user.role);
//     await prefs.setString("password", user.password);
//   }

//   // Notification status
//   Future<bool> getNotificationStatus() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getBool("notificationStatus") ?? false;
//   }

//   Future<void> setNotificationStatus(bool value) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool("notificationStatus", value);
//   }

// }

import 'dart:developer';

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

  Future<void> saveUserData(UserModel user) async{
    await service.users.doc(user.id).set(user.toMap());
  }
   
}

  // Future<void> updateUser(UserModel user) async {
  //   try {
  //     state = const AsyncLoading();

  //     // THIS is the actual correct method for updating
  //     await repository.saveUserData(user);

  //     state = const AsyncData(null);
  //   } catch (e, st) {
  //     state = AsyncError(e, st);
  //   }
  // }

