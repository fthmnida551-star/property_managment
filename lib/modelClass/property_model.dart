class PropertyModel {
  final String id;
  final String name;
  final String propertyType;
  final String location;
  final String description;
  final double amount;
  final double maintenanceCharge;
  final double sqft;
  final int bedrooms;
  final int bathrooms;
  final bool readyToMove;
  final bool carParking;
  final bool isOwner;
  final String ownername;
  final String contact;
  final String email;

  PropertyModel({
    required this.id,
    required this.name,
    required this.propertyType,
    required this.location,
    required this.description,
    required this.amount,
    required this.maintenanceCharge,
    required this.sqft,
    required this.bedrooms,
    required this.bathrooms,
    required this.readyToMove,
    required this.carParking,
    required this.isOwner,
    required this. ownername,
    required this. contact,
    required this. email,
  });

  // ✅ Factory: create from Firestore document
  factory PropertyModel.fromMap(Map<String, dynamic> data, String documentId) {
    return PropertyModel(
      id: documentId,
      name: data['name'] ?? 'No name',
      propertyType: data['propertyType'] ?? 'Unknown',
      location: data['location'] ?? 'No location',
      description: data['description'] ?? 'No description',
      amount: _toDouble(data['amount']),
      maintenanceCharge: _toDouble(data['maintenanceCharge']),
      sqft: _toDouble(data['sqft']),
      bedrooms: data['bedrooms'] ?? 0,
      bathrooms: data['bathrooms'] ?? 0,
      readyToMove: data['readyToMove'] ?? false,
      carParking: data['carParking'] ?? false,
      isOwner: data['isOwner'] ?? false,
      ownername: data['ownername'] ?? 'No name',
      contact: data['contact'] ?? 'No contact',
      email: data['email'] ?? 'No email',
    );
  }

  // ✅ Convert object to Firestore Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'propertyType': propertyType,
      'location': location,
      'description': description,
      'amount': amount,
      'maintenanceCharge': maintenanceCharge,
      'sqft': sqft,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'readyToMove': readyToMove,
      'carParking': carParking,
      'isOwner': isOwner,
      'ownername':ownername,
      'contact':contact,
      'email':email,
    };
  }

  // ✅ Create object from JSON (e.g., API or local file)
  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['id'] ?? '',
      name: json['name'] ?? 'No name',
      propertyType: json['propertyType'] ?? 'Unknown',
      location: json['location'] ?? 'No location',
      description: json['description'] ?? 'No description',
      amount: _toDouble(json['amount']),
      maintenanceCharge: _toDouble(json['maintenanceCharge']),
      sqft: _toDouble(json['sqft']),
      bedrooms: json['bedrooms'] ?? 0,
      bathrooms: json['bathrooms'] ?? 0,
      readyToMove: json['readyToMove'] ?? false,
      carParking: json['carParking'] ?? false,
      isOwner: json['isOwner'] ?? false,
       ownername:json['ownername'] ?? 'No name',
      contact: json['contact'] ?? 'No contact',
      email: json['email'] ?? 'No email',
    );
  }

  // ✅ Convert object to JSON (for storage or sending to API)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'propertyType': propertyType,
      'location': location,
      'description': description,
      'amount': amount,
      'maintenanceCharge': maintenanceCharge,
      'sqft': sqft,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'readyToMove': readyToMove,
      'carParking': carParking,
      'isOwner': isOwner,
    };
  }

  // 🔹 Helper to safely convert Firestore numbers to double
  static double _toDouble(dynamic value) {
    if (value is int) return value.toDouble();
    if (value is double) return value;
    return 0.0;
  }
}
