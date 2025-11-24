import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:property_managment/core/constant/firebase_const.dart';
import 'package:property_managment/modelClass/bookingmodel.dart';
import 'package:property_managment/modelClass/property_model.dart';

class PropertyRepo {
  final FirebaseService service;
  PropertyRepo(this.service);

  addProperties(Map<String, dynamic> propertyData) {
    service.properties.add(propertyData);
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

  Stream<List<PropertyModel>> getFilteredPropertyListStream(
    List<String> propertytype,
    RangeValues? price,
    RangeValues? sqft,
  ) {
    Query baseQuery = service.properties;

    // Filter 1: Property Type
    if (propertytype.isNotEmpty) {
      baseQuery = baseQuery.where("PROPERTY TYPE", whereIn: propertytype);
    }

    // Filter 2: Price Range (Firestore supports range on one field)
    if (price != null) {
      baseQuery = baseQuery
          .where("PROPERTY PRICE", isGreaterThanOrEqualTo: price.start)
          .where("PROPERTY PRICE", isLessThanOrEqualTo: price.end);
    }

    // Convert snapshots → model list
    return baseQuery.snapshots().map((snapshot) {
      final results = snapshot.docs.map((doc) {
        return PropertyModel.fromMap(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }).toList();

      // Apply SQFT range in memory
      if (sqft != null) {
        return results.where((property) {
          double propertySqft = double.tryParse(property.sqft.toString()) ?? 0;

          return propertySqft >= sqft.start && propertySqft <= sqft.end;
        }).toList();
      }

      return results;
    });
  }

  Stream<List<PropertyModel>> searchPropertiesStream(String query) {
    if (query.isEmpty) {
      return getAllPropertyDetailsList(); // reuse your main stream
    }

    final lowerQuery = query.toLowerCase();

    log(lowerQuery);
    return service.properties.snapshots().map((snapshot) {
      log("jjjjjjj");
      final all = snapshot.docs.map((doc) {
        return PropertyModel.fromMap(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }).toList();

      log("all length ${all.length}");

      return all.where((property) {
        return property.name.toLowerCase().contains(lowerQuery) ||
            property.location.toLowerCase().contains(lowerQuery);
      }).toList();
    });
  }


}
