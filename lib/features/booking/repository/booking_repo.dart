import 'dart:developer';

import 'package:property_managment/core/constant/firebase_const.dart';
import 'package:property_managment/modelClass/bookingmodel.dart';

class BookingRepo {
final FirebaseService service;
BookingRepo(this.service);

  addbookingDetails(Map<String, dynamic> bookingData) async {
    await service.bookingdetails.add(bookingData);
    await service.properties.doc(bookingData['PROPERTY_ID']).update({
      'IS_BOOKED': 'YES',
    });
  }
 Stream<BookingModel?> getBooking(String bookingId) {
  return service.bookingdetails
      .doc(bookingId)
      .snapshots()
      .map((doc) {
        if (doc.exists && doc.data() != null) {
          final Map<String,dynamic> data = doc.data()! as Map<String,dynamic>;
          // data['id'] = doc.id;
          return BookingModel.fromMap(doc.id,data);
        } else {
          print("No booking found for ID: $bookingId");
          return null;
        }
      }).handleError((e) {
        print("Error fetching booking: $e");
        return null;
      });
}

  Future<void> updateBooking(
    String id,
    Map<String, dynamic> updatedData,
  ) async {
    try {
      await service.bookingdetails .doc(id).update(updatedData);
      log("Booking updated successfully");
    } catch (e) {
      log("Error updating booking: $e");
    }
  }

   deleteBooking(String id, String propertyId) async {
    await service.bookingdetails
        .doc(id)
        .delete();
    await service.properties.doc(propertyId).update({
      'IS_BOOKED': 'NO',
    });
    // getAllPropertyDetails();
  }
 
}