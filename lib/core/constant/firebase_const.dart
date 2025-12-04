import 'package:cloud_firestore/cloud_firestore.dart';

class  FirebaseService {
  FirebaseFirestore fdb=FirebaseFirestore.instance;
  CollectionReference get users=> fdb.collection("STAFF");
  CollectionReference get properties=>fdb.collection("PROPERTIES");
  CollectionReference get bookingdetails=>fdb.collection("BOOKING DETAILS");
  CollectionReference get uploads=>fdb.collection("uploads");
}