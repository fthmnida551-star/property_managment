
// class PropertyModel {
//   final String id;         
//   final String name;       
//   final String location;   
//   final double amount;    
//   final int bedrooms;
//   final int bathrooms;
//   final int ;
//   final bool available;    

//   PropertyModel({
//     required this.id,
//     required this.name,
//     required this.location,
//     required this.amount,
//     required this.bedrooms,
//     required this.bathrooms;
//     required this.available,
//   });

//   // ✅ Create a PropertyModel object from a Firestore document
//   factory PropertyModel.fromMap(Map<String, dynamic> data, String documentId) {
//     return PropertyModel(
//       id: documentId,
//       name: data['name'] ?? 'No name',
//       location: data['location'] ?? 'No location',
//       price: _toDouble(data['price']),
//       bedrooms: data['bedrooms'] ?? 0,
//        bathrooms: data['bathrooms'] ?? 0,
//       available: data['available'] ?? false,
//     );
//   }

//   // ✅ Convert a PropertyModel object to a Map (useful for add/update)
//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'location': location,
//       'price': price,
//       'bedrooms': bedrooms,
//       'available': available,
//     };
//   }

//   // 🔹 Helper to safely convert Firestore numbers to double
//   static double _toDouble(dynamic value) {
//     if (value is int) return value.toDouble();
//     if (value is double) return value;
//     return 0.0;
//   }
// }
