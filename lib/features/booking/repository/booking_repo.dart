import 'dart:developer';

import 'package:property_managment/core/constant/firebase_const.dart';
import 'package:property_managment/features/notification/repository/notification_repository.dart';

class BookingRepo {
final FirebaseService service;
final NotificationRepository notificationRepo;
BookingRepo(this.service, this.notificationRepo);

  addbookingDetails(Map<String, dynamic> bookingData) async {
    await service.bookingdetails.add(bookingData);
    await notificationRepo.addNotification(
        title: "New Property booked",
        message: "${bookingData['propertyTitle']} has been added",
        addedStaff: "admin", // you can use user id or role
      );
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