import 'dart:developer';
import 'package:property_managment/core/constant/firebase_const.dart';
import 'package:property_managment/features/notification/repository/notification_repository.dart';
import 'package:property_managment/modelClass/property_model.dart';

class PropertyRepo {
  final FirebaseService service;
  final NotificationRepository notificationRepo;
  PropertyRepo(this.service, this.notificationRepo);

  Future<void> addProperties(
    Map<String, dynamic> propertyData,
    String userName,
  ) async {
    try {
      // final docRef = await service.properties.add(propertyData);

      await service.properties.add(propertyData);

      await notificationRepo.addNotification(
        title: "New Property Added",
        message: "${propertyData['BUILDING NAME']} has been added",
        type: "Added",
        addedStaff: userName, // you can use user id or role
      );

      log("Property Added & Notification Sent");
    } catch (e) {
      log("Error adding property: $e");
    }
  }

  Future<void> updateproperty(
    String id,
    Map<String, dynamic> updatedData,
  ) async {
    try {
      service.properties.doc(id).update(updatedData);
      log("Properties updated successfully");
    } catch (e) {
      log("Error updating properties: $e");
    }
  }

  Stream<List<PropertyModel>> getAllPropertyDetailsList() {
    return service.properties
        .orderBy('ADDED_DATE', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => PropertyModel.fromMap(
                  doc.data() as Map<String, dynamic>,
                  doc.id,
                ),
              )
              .toList(),
        );
  }

Future<PropertyModel> getSingleProperty(String propertyId) async {
  final doc = await service.properties.doc(propertyId).get();

  if (doc.exists) {
    return PropertyModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
  } else {
    throw Exception("Property not found");
  }
}


  deleteProperty(PropertyModel property,String userName) async {
    await service.properties.doc(property.id).delete();
    if (property.isBooked == true) {
      await service.bookingdetails.doc(property.bookingid).delete();
    }

    await notificationRepo.addNotification(
      title: "Property Removed ",
      message: "${property.name} has been Removed",
      type: "Removed",
      addedStaff: userName, // you can use user id or role
    );
  }
}
