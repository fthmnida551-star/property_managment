import 'dart:developer';
import 'package:property_managment/core/constant/firebase_const.dart';
import 'package:property_managment/features/notification/repository/notification_repository.dart';
import 'package:property_managment/modelClass/bookingmodel.dart';
import 'package:property_managment/modelClass/property_model.dart';

class BookingRepo {
  final FirebaseService service;

  final NotificationRepository notificationRepo;
  BookingRepo(this.service,this.notificationRepo);

  

  addbookingDetails(Map<String, dynamic> bookingData,String userName, PropertyModel property) async {
    await service.bookingdetails.doc(bookingData['BOOKING_ID']) .set(bookingData);
    await service.properties.doc(bookingData['PROPERTY_ID']).update({
      'IS_BOOKED': 'YES',
      'BOOKING_ID': bookingData['BOOKING_ID']
    });
     String ownerName =
      (property.ownername != null && property.ownername.trim().isNotEmpty)
          ? property.ownername
          : "PlotX";

      String message = "${property.ownername}'s property is booked by ${bookingData['NAME']}";
     await notificationRepo.addNotification(
        title: "New Property booked",
        message: message,
        type: "Booked",
        addedStaff: userName, 
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

  deleteBooking(String id, String propertyId, String userName) async {
  // Delete booking entry
  await service.bookingdetails.doc(id).delete();

  // Mark property as NOT booked
  await service.properties.doc(propertyId).update({
    'IS_BOOKED': 'NO',
    'BOOKING_ID': null,
  });

  // 🔥 Fetch property to check owner name
  final propertyDoc = await service.properties.doc(propertyId).get();

  String ownerName = "";

if (propertyDoc.exists) {
  final data = propertyDoc.data() as Map<String, dynamic>?;

  ownerName = data?['OWNER_NAME'] ?? "";
}


  // 🔥 Condition: If no owner → use PlotX
  String finalOwnerName =
      ownerName.trim().isNotEmpty ? ownerName : "PlotX";

  // 🔥 Create message
  String message =
      "${finalOwnerName}'s property booking has been cancelled";

  // Add notification
  await notificationRepo.addNotification(
    title: "Booking Cancelled",
    message: message,
    type: "Cancelled",
    addedStaff: userName,
  );
}

}