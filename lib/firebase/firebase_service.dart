import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:property_managment/firebase_options.dart';
import 'package:property_managment/modelClass/bookingmodel.dart';
import 'package:property_managment/modelClass/property_model.dart';
import 'package:property_managment/modelClass/user_model.dart';



class FirebaseService {
  static late final FirebaseFirestore fdb;

  List< PropertyModel> PropertyList=[];

  initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
    );

    fdb = FirebaseFirestore.instance;
  }

 

  void addUsers(Map<String, dynamic> finaldetails) {
    fdb.collection("STAFF").add(finaldetails).then((
      DocumentReference<Map<String, dynamic>> docRef,
    ) {
      final String id = docRef.id;
      log("adding users");
    });
  }


final FirebaseService firebaseService = FirebaseService();

void addNewProperty() async {
  BookingModel newProperty =BookingModel(
    name: "faiha",
    email: "faiha@gmail.com",
    phone: 9988776655,
    date: 30-10-2025,
  );

  await firebaseService. getBookedProperty(newProperty);
}

  Future<void> getBookedProperty(BookingModel newProperty) async {}

  
}
