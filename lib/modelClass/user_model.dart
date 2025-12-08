
class UserModel {
  final String id;
  final String name;
  final dynamic email;
  final String role;
  final dynamic password;
  final String? phone;

  UserModel({required this.id, required this.name, required this.email, required this.role,this.password, this.phone});

  
  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      id: id,
      name:  map['USER_NAME']?? "",
      email:  map['USER_EMAIL']??"",
      role:  map["USER_ROLE"]??"",
      password:  map['USER_PASSWORD']??"",
      phone:  map['USER_PHONE']??"",
      
    );
  }

  get phoneNumber => null;

  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'USER_NAME': name,
      'USER_EMAIL': email,
      'USER_ROLE':role,
      'USER_PASSWORD': password,
      'USER_PHONE': phone,
    };
  }
}

