import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
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
  
}
