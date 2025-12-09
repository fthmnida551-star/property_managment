class UserModel {
  final String id;
  final String name;
  final String email;
  final String role;
  final String password;
  final String Mobilenumber;
  final String profileImage;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.password,
    required this.Mobilenumber,
    required this.profileImage,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      id: id,
      name: map['USER_NAME'] ?? "",
      email: map['USER_EMAIL'] ?? "",
      role: map['USER_ROLE'] ?? "",
      password: map['USER_PASSWORD'] ?? "",
      Mobilenumber: map["USER_MOBILENUMBER"]??"",
      profileImage: map['PROFILE_IMAGE'] ?? "",  
       // <-- FIXED
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ID':id,
      'USER_NAME': name,
      'USER_EMAIL': email,
      'USER_ROLE': role,
      'USER_PASSWORD': password,
      "USER_MOBILENUMBER":Mobilenumber,
      'PROFILE_IMAGE': profileImage,  // <-- FIXED
    };
  }
}
