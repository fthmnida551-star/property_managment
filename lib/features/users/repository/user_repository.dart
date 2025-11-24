import 'dart:developer';
import 'package:property_managment/core/constant/firebase_const.dart';
import 'package:property_managment/modelClass/user_model.dart';

class USersRepository{
  final FirebaseService service;
  USersRepository(this.service);
  Future<void> addUsers(Map<String, dynamic> userDetails) async {
    try {
      final docRef = await service.users.add(userDetails);
      log("User Added Successfully! ID: ${docRef.id}");
    } catch (e) {
      log("Error Adding User: $e");
    }
  }
  Stream<List<UserModel>> getAllUsersList() {
    return service.users.snapshots().map(
      (snapshot) {
        return snapshot.docs.map(
          (doc) => UserModel.fromMap(doc.data() as Map<String, dynamic>,doc.id)
        ).toList();
      },
    );
  }
 
  Future<void> updateUser(String id, Map<String, dynamic> updatedData) async {
  try {
    await service.users.doc(id).update(updatedData);
    log("User updated successfully");
  } catch (e) {
    log("Error updating user: $e");
  }
}
void deleteUser(String id) async {
    await service.users.doc(id).delete();
  getAllUsersList();
  }
}


