import 'dart:developer';
import 'package:property_managment/core/constant/firebase_const.dart';
import 'package:property_managment/features/notification/repository/notification_repository.dart';
import 'package:property_managment/modelClass/bookingmodel.dart';

class BookingRepo {
  final FirebaseService service;
  final NotificationRepository notificationRepo;
  BookingRepo(this.service, this.notificationRepo);

  addbookingDetails(Map<String, dynamic> bookingData, String userName) async {
    await service.bookingdetails
        .doc(bookingData['BOOKING_ID'])
        .set(bookingData);
    await service.properties.doc(bookingData['PROPERTY_ID']).update({
      'IS_BOOKED': 'YES',
      'BOOKING_ID': bookingData['BOOKING_ID'],
    });
    await notificationRepo.addNotification(
      title: "New Property booked",
      message: "property has been booked",
      type: "Booked",
      addedStaff: userName,
    );
  }

  // Stream<BookingModel?> getBooking(String bookingId) {
  //   log("hhhhhhhhhhh bookingId $bookingId");
  //   return service.bookingdetails
  //       .doc(bookingId)
  //       .snapshots()
  //       .map((doc) {
  //         if (doc.exists && doc.data() != null) {
            
  //           final Map<String, dynamic> data =
  //               doc.data()! as Map<String, dynamic>;

  //           return BookingModel.fromMap(doc.id, data);
  //         } else {
  //           print("No booking found for ID: $bookingId");
  //           return null;
  //         }
  //       })
  //       .handleError((e) {
  //         print("Error fetching booking: $e");
  //         return null;
  //       });
  // }

  Future<BookingModel?> getBooking(String bookingId) async {
  try {
    log("Fetching booking for ID: $bookingId");

    final doc = await service.bookingdetails.doc(bookingId).get();

    if (doc.exists && doc.data() != null) {
      final Map<String, dynamic> data =
          doc.data()! as Map<String, dynamic>;

      return BookingModel.fromMap(doc.id, data);
    } else {
      print("No booking found for ID: $bookingId");
      return null;
    }

  } catch (e) {
    print("Error fetching booking: $e");
    return null;
  }
}


  Future<void> updateBooking(
    String id,
    Map<String, dynamic> updatedData,
  ) async {
    try {
      await service.bookingdetails.doc(id).update(updatedData);
      log("Booking updated successfully");
    } catch (e) {
      log("Error updating booking: $e");
    }
  }

  deleteBooking(String id, String propertyId, String userName) async {
    await service.bookingdetails.doc(id).delete();
    await service.properties.doc(propertyId).update({'IS_BOOKED': 'NO'});
    // getAllPropertyDetails();
    await notificationRepo.addNotification(
      title: "booking cancelled",
      message: "booking cancelled",
      type: "Cancelled",
      addedStaff: userName, // you can use user id or role
    );
  }
}
