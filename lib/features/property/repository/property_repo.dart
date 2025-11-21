import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:property_managment/core/constant/firebase_const.dart';

class BookingRepository {
final FirebaseService service;
BookingRepository(this.service);

  Future<void> deleteBooking({
    required String bookingId,
    required String propertyId,
  }) async {
    await service.bookingdetails. doc(bookingId).delete();

    await service.bookingdetails. doc(propertyId).update({
      'IS_BOOKED': 'NO',
    });
  }
}

