import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:property_managment/firebase_options.dart';
import 'package:property_managment/modelClass/property_model.dart';

class FirebaseService {
  static late final FirebaseFirestore fdb;

  List< PropertyModel> PropertyList=[];

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
      getAllPropertyModel();
    // getAllPersonList();
    });}

    void getAllPropertyModel() async {
    PropertyList.clear();
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await fdb.collection('property details').get();
    querySnapshot.docs.map((element) {
      final String id = element.id;
      final Map<String, dynamic> data = element.data();
      PropertyList.add(PropertyModel.fromMap(data, id));
    });
  }

    }
   