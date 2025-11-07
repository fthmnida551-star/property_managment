
// // class BookingModel {
// //   final String name;
// //   final String email;
// //   final String contact;
// //   final int date;
// //   final String id;

// //   BookingModel({
// //     required this.name,
// //     required this.email,
// //     required this.contact,
// //     required this.date,
// //     required this.id,
// //   });


// //   // factory BookingModel.fromMap(Map<String, dynamic> map, String id) {
// //   //   return BookingModel(
// //   //     name: map['NAME'] ?? 'No name',
// //   //     email: map['EMAIL'] ?? 'No email',
// //   //     contact: map['CONTACT']?.toString() ?? 'No contact',
// //   //     date: map['DATE'] ?? 'No date',
// //   //     id: id,
// //   //   );
// //   // }
// //   factory BookingModel.fromMap(Map<String, dynamic> map, String id) {
// //   return BookingModel(
// //     name: map['NAME'] ?? map['name'] ?? 'No name',
// //     email: map['EMAIL'] ?? map['email'] ?? 'No email',
// //     contact: map['CONTACT']?.toString() ?? map['contact']?.toString() ?? 'No contact',
// //     date: map['DATE'] ?? map['date'] ?? 0,
// //     id: id,
// //   );
// // }


  
// //   Map<String, dynamic> toJson() {
// //     return {
// //       'NAME': name,
// //       'EMAIL': email,
// //       'CONTACT': contact,
// //       'DATE': date,
// //       'id': id,
// //     };
// //   }
// // }
// class BookingModel {
//   final String name;
//   final String email;
//   final String contact;
//   final int date;
//   final String id;
//   final String propertyId;

//   BookingModel({
//     required this.name,
//     required this.email,
//     required this.contact,
//     required this.date,
//     required this.id,
//     required this.propertyId,
//   });

//   /// Factory constructor to create a BookingModel from Firestore map
//   factory BookingModel.fromMap(Map<String, dynamic> map, String id) {
//     return BookingModel(
//       name: (map['NAME'] ?? map['name'] ?? '').toString(),
//       email: (map['EMAIL'] ?? map['email'] ?? '').toString(),
//       contact: (map['CONTACT'] ?? map['contact'] ?? '').toString(),
//       propertyId: (map['property id'] ?? map ['property id']??'').toString(),
//       date: (map['DATE'] ?? map['date'] ?? 0) is int
//           ? (map['DATE'] ?? map['date'] ?? 0)
//           : int.tryParse(map['DATE']?.toString() ?? '0') ?? 0,
//       id: id,
//     );
//   }

//   /// Converts model to JSON for Firestore upload
//   Map<String, dynamic> toJson() {
//     return {
//       'NAME': name,
//       'EMAIL': email,
//       'CONTACT': contact,
//       'DATE': date,
//       'id': id,
//       'propertyId':propertyId,
//     };
//   }
// }
class BookingModel {
  final String name;
  final String email;
  final String contact;
  final int date;
  final String id;
  final String propertyId;

  BookingModel({
    required this.name,
    required this.email,
    required this.contact,
    required this.date,
    required this.id,
    required this.propertyId,
  });

  factory BookingModel.fromMap(Map<String, dynamic> map, String id) {
    return BookingModel(
      name: (map['NAME'] ?? map['name'] ?? '').toString(),
      email: (map['EMAIL'] ?? map['email'] ?? '').toString(),
      contact: (map['CONTACT'] ?? map['contact'] ?? '').toString(),
     // propertyId: (map['PROPERTY_ID'] ?? map[''] ?? 'propertyId').toString(),
     propertyId: (map['PROPERTY_ID'] ?? map['property id'] ?? map['propertyId'] ?? '').toString(),

      date: (map['DATE'] ?? map['date'] ?? 0) is int
          ? (map['DATE'] ?? map['date'] ?? 0)
          : int.tryParse(map['DATE']?.toString() ?? '0') ?? 0,
      id: id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'NAME': name,
      'EMAIL': email,
      'CONTACT': contact,
      'DATE': date,
      'BOOKING_ID': id,
      'PROPERTY_ID': propertyId,
    };
  }
}
