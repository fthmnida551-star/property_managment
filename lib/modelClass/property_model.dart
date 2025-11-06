// class PropertyModel {
//   final String id;
//   final String name;
//   final String propertyType;
//   final String location;
//   final String description;
//   final double price;
//   final int bhk;
//   final int bathrooms;
//   final bool readyToMove;
//   // final double carpetArea;
//   final bool carParking;
//   final double maintenance;
//   final double sqft;
//   final String aminities;
//   final bool isOwner;
//   final String ownername;
//   final String contact;
//   final String email;
//   final bool isBooked;
//   final String bookingid;

//   PropertyModel({
//     required this.id,
//     required this.name,
//     required this.propertyType,
//     required this.location,
//     required this.description,
//     required this.price,
//     required this.maintenance,
//     required this.sqft,
//     required this.bhk,
//     required this.bathrooms,
//     required this.readyToMove,
//     required this.carParking,
//     // required this.carpetArea,
//     required this.aminities,
//     required this.isOwner,
//     required this.ownername,
//     required this.contact,
//     required this.email,
//     required this.isBooked,
//     required this.bookingid,
//   });

//   /// Convert model to Map (for Firestore or JSON)
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'BUILDING NAME': name,
//       'PROPERTY TYPE': propertyType,
//       'PROPERTY LOCATION': location,
//       'PROPERTY DESCRIPTION': description,
//       'PROPERTY PRICE': price,
//       'BHK': bhk,
//       'BATHROOMS': bathrooms,
//       'READY_TO_MOVE': readyToMove,
//       // 'CARPET AREA': carpetArea,
//       'carParking': carParking,
//       'MAINTENANCE': maintenance,
//       'PROPERTY SQFT': sqft,
//       'AMINITIES': aminities,
//       'IS_OWN_PROPERTY': isOwner,
//       'OWNER_NAME': ownername,
//       'OWNER_CONTACT': contact,
//       'OWNER_EMAIL': email,
//       'IS_BOOKED': isBooked,
//       'BOOKING_ID': bookingid,
//     };
//   }

//   /// Create model from Map (for Firestore or JSON)
//   factory PropertyModel.fromMap(Map<String, dynamic> map) {
//     return PropertyModel(
//       id: map['id'] ?? '',
//       name: map['BUILDING NAME'] ?? '',
//       propertyType: map['PROPERTY TYPE'] ?? '',
//       location: map['PROPERTY LOCATION'] ?? '',
//       description: map['PROPERTY DESCRIPTION'] ?? '',
//       price: (map['PROPERTY PRICE'] ?? 0).toDouble(),
//       bhk: map[' BHK']??0,
//       bathrooms: (map[' BATHROOMS'] ?? 0).toInt(),
//       readyToMove: map['READY_TO_MOVE']=='YES'?true :  false,
//       // carpetArea: (map[' CARPET AREA'] ?? 0).toDouble(),
//       carParking: map['CARPARKING'] =='YES'?true: false,
//       maintenance: (map[' MAINTENANCE'] ?? 0).toDouble(),
//       sqft: (map[' PROPERTY SQFT'] ?? 0).toDouble(),
//       aminities: map['  AMINITIES'] ?? '',
//       isOwner: map['IS_OWN_PROPERTY'] =="YES"? true :false,
//       ownername: map['OWNER_NAME'] ?? '',
//       contact: map['OWNER_CONTACT'] ?? '',
//       email: map['OWNER_EMAIL'] ?? '',
//       isBooked: map['IS_BOOKED'] =="YES"? true :false,
//       bookingid: map['BOOKING_ID'] ?? '',
//     );
//   }
// }
class PropertyModel {
  final String id;
  final String name;
  final String propertyType;
  final String location;
  final String description;
  final double price;
  final int bhk;
  final int bathrooms;
  final bool readyToMove;
  final bool carParking;
  final double maintenance;
  final double sqft;
  final String aminities;
  final bool isOwner;
  final String ownername;
  final String contact;
  final String email;
  final bool isBooked;
  final String bookingid;

  PropertyModel({
    required this.id,
    required this.name,
    required this.propertyType,
    required this.location,
    required this.description,
    required this.price,
    required this.maintenance,
    required this.sqft,
    required this.bhk,
    required this.bathrooms,
    required this.readyToMove,
    required this.carParking,
    required this.aminities,
    required this.isOwner,
    required this.ownername,
    required this.contact,
    required this.email,
    required this.isBooked,
    required this.bookingid,
  });

  /// 🔹 Convert model to Map (for Firestore)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'BUILDING NAME': name,
      'PROPERTY TYPE': propertyType,
      'PROPERTY LOCATION': location,
      'PROPERTY DESCRIPTION': description,
      'PROPERTY PRICE': price,
      'BHK': bhk,
      'BATHROOMS': bathrooms,
      'READY_TO_MOVE': readyToMove ? 'YES' : 'NO',
      'CARPARKING': carParking ? 'YES' : 'NO',
      'MAINTENANCE': maintenance,
      'PROPERTY SQFT': sqft,
      'AMINITIES': aminities,
      'IS_OWN_PROPERTY': isOwner ? 'YES' : 'NO',
      'OWNER_NAME': ownername,
      'OWNER_CONTACT': contact,
      'OWNER_EMAIL': email,
      'IS_BOOKED': isBooked ? 'YES' : 'NO',
      'BOOKING_ID': bookingid,
    };
  }

  /// 🔹 Create model from Firestore Map
  factory PropertyModel.fromMap(Map<String, dynamic> map) {
    return PropertyModel(
      id: map['id'] ?? '',
      name: map['BUILDING NAME'] ?? '',
      propertyType: map['PROPERTY TYPE'] ?? '',
      location: map['PROPERTY LOCATION'] ?? '',
      description: map['PROPERTY DESCRIPTION'] ?? '',
      price: (map['PROPERTY PRICE'] ?? 0).toDouble(),
      bhk: map['BHK'] ?? 0,
      bathrooms: map['BATHROOMS'] ?? 0,
      readyToMove: (map['READY_TO_MOVE'] == 'YES'),
      carParking: (map['CARPARKING'] == 'YES'),
      maintenance: (map['MAINTENANCE'] ?? 0).toDouble(),
      sqft: (map['PROPERTY SQFT'] ?? 0).toDouble(),
      aminities: map['AMINITIES'] ?? '',
      isOwner: (map['IS_OWN_PROPERTY'] == 'YES'),
      ownername: map['OWNER_NAME'] ?? '',
      contact: map['OWNER_CONTACT'] ?? '',
      email: map['OWNER_EMAIL'] ?? '',
      isBooked: (map['IS_BOOKED'] == 'YES'),
      bookingid: map['BOOKING_ID'] ?? '',
    );
  }
}
