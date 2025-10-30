// class EditprofileModel {
//   String? id ;
//   final String profile;
//   final dynamic email;
//   final String password;

//   EditprofileModel({this.id, required this.profile, required this.email, required this.password});


//  factory EditprofileModel.fromMap(Map<String, dynamic> map, String id) {
//     return EditprofileModel(
//       id:  id,
//       profile:  map['PROFILE'] as String,
//       email:  map['USER_EMAIL'] as dynamic,
//       password:  map['USER_PASSWORD'] as String,
     
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'PROFILE': profile,
//       'USER_EMAIL': email,
//       'USER_PASSWORD': password,
      
//     };
//   }
// }