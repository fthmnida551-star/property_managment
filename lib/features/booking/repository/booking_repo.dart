import 'dart:developer';

import 'package:property_managment/core/constant/firebase_const.dart';

class BookingRepo {
final FirebaseService service;
BookingRepo(this.service);

  addbookingDetails(Map<String, dynamic> bookingData) async {
    await service.bookingdetails.add(bookingData);
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
}