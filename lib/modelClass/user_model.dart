
class UserModel {
  final String id;
  final String name;
  final dynamic email;
  final String role;
  final dynamic password;

  UserModel(this.id, this.name, this.email, this.role,this.password);

  
  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      id,
      map['USER_NAME']?? "",
      map['USER_EMAIL']??"",
      map["USER_ROLE"]??"",
      map['USER_PASSWORD']??"",
      
    );
  }

  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'USER_NAME': name,
      'USER_EMAIL': email,
      'USER_ROLE':role,
      'USER_PASSWORD': password,
    };
  }
}

