import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:property_managment/core/constant/firebase_const.dart';
import 'package:property_managment/features/notification/repository/notification_repository.dart';
import 'package:property_managment/modelClass/property_model.dart';

class PropertyRepo {
  final FirebaseService service;
  final NotificationRepository notificationRepo;
  PropertyRepo(this.service, this.notificationRepo);

  Future<void> addProperties(Map<String, dynamic> propertyData) async {
    try {
      await service.properties.add(propertyData);

      await notificationRepo.addNotification(
        title: "New Property Added",
        message: "${propertyData['propertyTitle']} has been added",
        addedStaff: "admin", // you can use user id or role
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
    return service.properties.snapshots().map(
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
  
 
deleteProperty(PropertyModel property) async {
  await service.properties
      .doc(property.id)
      .delete();
  if (property.isBooked == true) {
    await service.bookingdetails
        .doc(property.bookingid)
        .delete();
  }
  // getAllPropertyDetails();
}



  // void getAllPropertyDetailsList() async {
  //     propertyDetailsList.clear();

  //     try {
  //       final QuerySnapshot<Map<String, dynamic>> querySnapshot = await fdb
  //           .collection('PROPERTIES')
  //           .orderBy('ADDED_DATE', descending: true)
  //           .get();

  //       for (var element in querySnapshot.docs) {
  //         // final String id = element.id;
  //         final Map<String, dynamic> data = element.data();
  //         data.keys.forEach((element) => log(element));
  //         log("Document keys: ${data.keys}");
  //         log("jjjjjjjjjj ${data['PROPERTY PRICE']}");
  //         log("jghjfhfgjh ${(data[' BHK'] is int) ? 1111 : 666}");

  //         // Make sure PropertyModel.fromJson can handle the ID
  //         propertyDetailsList.add(PropertyModel.fromMap(data, element.id));
  //       }
  // // Refresh the UI
  //     } catch (e) {
  //       debugPrint("Error fetching property details: $e");
  //     }
  //   }

  

  


}
