import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  final String name;
  final String email;
  final String contact;
  final String date;
  final DateTime addedDate; 
  final String id;
  final String propertyId;
 

  BookingModel({
    required this.name,
    required this.email,
    required this.contact,
    required this.date,
    required this.addedDate,
    required this.id,
    required this.propertyId,
    
  });

  // Convert Firestore document → BookingModel
  factory BookingModel.fromMap(String id,Map<String, dynamic> map) {
    return BookingModel(
      name: map['NAME'] ?? '',
      email: map['EMAIL'] ?? '',
      contact: map['CONTACT'].toString(),
      date: map['DATE'] ?? '',
      addedDate: map['ADDED_DATE'] is Timestamp
          ? (map['ADDED_DATE'] as Timestamp).toDate()
          : DateTime.tryParse(map['ADDED_DATE'] ?? '') ?? DateTime.now(),
      id: id,
      propertyId: map['PROPERTY_ID'] ?? '',
    
    );
  }

  // Convert BookingModel → Firestore document
  Map<String, dynamic> toMap() {
    return {
      'NAME': name,
      'EMAIL': email,
      'CONTACT': contact,
      'DATE': date,
      'ADDED_DATE': addedDate, 
     'BOOKING_ID' : id,
      'PROPERTY_ID': propertyId,
      
    };
  }
}
