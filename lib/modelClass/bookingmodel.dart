class BookingModel {
  final String name;
  final String email;
  final String contact;
  final String date;
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

  /// ✅ Create BookingModel from Firestore document
  factory BookingModel.fromMap(Map<String, dynamic> map, String documentId) {
    return BookingModel(
      name: map['NAME']?.toString() ?? '',
      email: map['EMAIL']?.toString() ?? '',
      contact: map['CONTACT']?.toString() ?? '', // 🔹 converts int → String
      date: map['DATE']?.toString() ?? '',
      id: documentId,
      propertyId: map['PROPERTY_ID']?.toString() ?? '',
    );
  }

  /// ✅ Convert BookingModel to Firestore-friendly map
  Map<String, dynamic> toMap() {
    return {
      'NAME': name,
      'EMAIL': email,
      'CONTACT': contact, // keep as string to avoid type conflict later
      'DATE': date,
      'PROPERTY_ID': propertyId,
    };
  }
}
