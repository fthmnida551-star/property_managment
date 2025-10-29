import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:property_managment/firebase_options.dart';
import 'package:property_managment/modelClass/user_model.dart';
List<UserModel> UsersList=[];

class FirebaseService {
  static late final FirebaseFirestore fdb;

  initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // set settings
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
    );
    // firestore database initializing
    fdb = FirebaseFirestore.instance;
  
  }
  void addProperties(Map<String, dynamic> propertyData ) async {
    await fdb
        .collection("PROPERTIES")
        .add(propertyData)
        .then((DocumentReference<Map<String, dynamic>> docRef) {
      final String id = docRef.id;

      log("Insert Data with $id");
    });
    getAllUsersList(
      
    );
  }

  void addUsers(Map<String, dynamic> finaldetails) {
  fdb.collection("STAFF").add(finaldetails).then((DocumentReference<Map<String,dynamic>> docRef){
    final String id =docRef.id;
    log("adding users");
  });
  }
  void getAllUsersList()async{

    UsersList.clear();

    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await fdb.collection('STAFF').get();
    querySnapshot.docs.map((element) {
      final String id = element.id;
      final Map<String, dynamic> data = element.data();
      UsersList.add(UserModel.fromMap(data, id));
      
     });
     log("read userslist");

  }
}
  

