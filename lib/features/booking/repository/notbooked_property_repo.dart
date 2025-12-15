import 'package:property_managment/core/constant/firebase_const.dart';
import 'package:property_managment/modelClass/property_model.dart';

class NotBookedPropertyRepo {
  final FirebaseService service;

  NotBookedPropertyRepo(this.service);

  Stream<List<PropertyModel>> getAllNotBookedPropertyDetailsList() {
    return service.properties
        .where('IS_BOOKED', isEqualTo: 'NO')
        .orderBy('ADDED_DATE', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => PropertyModel.fromMap(
                  doc.data() as Map<String, dynamic>,
                  doc.id,
                ),
              )
              .toList(),
        );
  }
}
