class LoginModel {
  String? id;
  final dynamic email;
  final dynamic password;

  LoginModel(this.id, this.email, this.password);

  factory LoginModel.fromJson(Map<String, dynamic> json, String id) {
    return LoginModel(
      id,
      json["email"],
      json["password"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
    };
  }

  @override
  String toString() {
    return "id: $id, email: $email, password: $password";
  }
}
