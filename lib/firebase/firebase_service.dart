import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:property_managment/firebase_options.dart';

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
    // getAllPersonList();
  }

  void addUsers(Map<String, dynamic> finaldetails) {
  fdb.collection("STAFF").add(finaldetails).then((DocumentReference<Map<String,dynamic>> docRef){
    final String id =docRef.id;
    log("adding users");
  });
  }
  
}
