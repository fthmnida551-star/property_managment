import 'dart:developer';
import 'package:property_managment/core/constant/firebase_const.dart';

class NotificationRepository {
  final FirebaseService service;
  NotificationRepository(this.service);
  Future<void> addNotification({
    required String title,
    required String message,
    required String addedStaff,
    required String type,
  }) async {
    log("reached here");
    await service.notifications.add({
      "title": title,
      "message": message,
      "type": type,
      "addedStaff":addedStaff,
      "timestamp": DateTime.now().millisecondsSinceEpoch,
    });
  }

  Stream<List<Map<String, dynamic>>> getNotifications() {
    return service.notifications
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList(),
        );
  }
}
