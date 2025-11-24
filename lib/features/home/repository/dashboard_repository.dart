import 'dart:developer';
import 'package:property_managment/core/constant/firebase_const.dart';
import 'package:property_managment/modelClass/bookingmodel.dart';
import 'package:property_managment/modelClass/property_model.dart';

class DashboardRepository {
  final FirebaseService service;
  DashboardRepository(this.service);

  Stream<int> getPropertyCount() {
    return service.properties.snapshots().map((snapshot) {
      return snapshot.size;
    });
  }
    Stream<int> getBookedCount() {
  return service.bookingdetails.snapshots().map((snapshot) {
    return snapshot.size;
  });
}
Stream<List<BookingModel>> getBookedProperties() {
  return service.bookingdetails
      .orderBy("ADDED_DATE", descending: true)
      .snapshots()
      .map((snapshot) {
        return snapshot.docs.map((doc) {
          return BookingModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);
        }).toList();
      });
}
 Stream<PropertyModel?> getPropertyById(String propertyId) {
  if (propertyId.isEmpty) {
    log("Empty propertyId passed!");
    return Stream.value(null);
  }

  return service.properties.doc(propertyId).snapshots().map((doc) {
    if (doc.exists && doc.data() != null) {
      final data = doc.data() as Map<String, dynamic>;
      return PropertyModel.fromMap(data, doc.id);
    } else {
      log("No property found for ID: $propertyId");
      return null;
    }
  });
}

}
