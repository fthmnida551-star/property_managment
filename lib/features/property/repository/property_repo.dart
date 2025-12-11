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
    await service.properties.add(propertyData);

    String displayName;
    final propertyName = (propertyData['BUILDING NAME'] as String?)?.trim();
    final ownerName = (propertyData['OWNER NAME'] as String?)?.trim();

    if (propertyName != null && propertyName.isNotEmpty) {
      displayName = "$propertyName has been added"; // CASE 1: Building name exists
    } else if (ownerName != null && ownerName.isNotEmpty) {
      displayName = "$ownerName's property has been added"; // CASE 2: Only owner name exists
    } else {
      displayName = "PlotX's property has been added"; // CASE 3: Neither exists
    }

    await notificationRepo.addNotification(
      title: "New Property Added",
      message: displayName,
      type: "Added",
      addedStaff: userName,
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
deleteProperty(PropertyModel property, String userName) async {
  await service.properties.doc(property.id).delete();

  if (property.isBooked == true) {
    await service.bookingdetails.doc(property.bookingid).delete();
  }
String displayName;

final propertyName = property.name?.trim();
final ownerName = property.ownername?.trim();

if (propertyName != null && propertyName.isNotEmpty) {
  displayName = "$propertyName"; // building name
} else if (ownerName != null && ownerName.isNotEmpty) {
  displayName = "$ownerName's property"; // owner name
} else {
  displayName = "PlotX's property"; // fallback
}


  await notificationRepo.addNotification(
    title: "Property Removed",
    message: "$displayName has been removed",
    type: "Removed",
    addedStaff: userName,
  );
}


}
