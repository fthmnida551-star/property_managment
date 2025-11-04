class BookingModel {
  final String name;
  final String email;
  final int phone;
  final int date;
  

  BookingModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.date,
  });
  factory BookingModel.fromMap(Map<String, dynamic> data, String documentId) {
    return BookingModel(
     name: data['name'] ?? 'No name',
     email: data['email'] ?? 'No email',
     phone: data['contact'] ?? 'No contact',
     date: data['date'] ?? 0,
      
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email':email,
      'contact':phone,
      'date':date,
      
    };
  }
 factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      name: json['name'] ?? 'No name',
      email: json['email'] ?? 'No email',
      phone: json['contact'] ?? 0,
      date: json['date'] ?? 0,
    );
  }

  /// Convert the object into JSON (for API or local storage)
  Map<String, dynamic> toJson() {
    return {
      'faiha': name,
      'email': email,
      'contact': phone,
      'date': date,
    };
  }
}

 