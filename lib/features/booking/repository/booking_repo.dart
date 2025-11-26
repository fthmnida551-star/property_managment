import 'dart:developer';
import 'package:property_managment/core/constant/firebase_const.dart';
import 'package:property_managment/features/notification/repository/notification_repository.dart';
import 'package:property_managment/modelClass/bookingmodel.dart';

class BookingRepo {
  final FirebaseService service;
  final NotificationRepository notificationRepo;
  BookingRepo(this.service,this.notificationRepo);

  addbookingDetails(Map<String, dynamic> bookingData) async {
    await service.bookingdetails.doc(bookingData['BOOKING_ID']).set(bookingData);
    await service.properties.doc(bookingData['PROPERTY_ID']).update({
      'IS_BOOKED': 'YES',
      'BOOKING_ID': bookingData['BOOKING_ID']
    });
     await notificationRepo.addNotification(
        title: "New Property booked",
        message: "${bookingData['propertyTitle']} has been booked",
        addedStaff: "admin", // you can use user id or role
      );
  }

  Stream<BookingModel?> getBooking(String bookingId) {
    log("hhhhhhhhhhh bookingId $bookingId");
    return service.bookingdetails
        .doc(bookingId)
        .snapshots()
        .map((doc) {
          if (doc.exists && doc.data() != null) {
            final Map<String, dynamic> data =
                doc.data()! as Map<String, dynamic>;
            // data['id'] = doc.id;
            return BookingModel.fromMap(doc.id, data);
          } else {
            print("No booking found for ID: $bookingId");
            return null;
          }
        })
        .handleError((e) {
          print("Error fetching booking: $e");
          return null;
        });
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

  deleteBooking(String id, String propertyId) async {
    await service.bookingdetails.doc(id).delete();
    await service.properties.doc(propertyId).update({'IS_BOOKED': 'NO'});
    // getAllPropertyDetails();
     await notificationRepo.addNotification(
        title: "booking cancelled",
        message: "booking cancelled",
        addedStaff: "admin", // you can use user id or role
     );
     
  }
}