import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:property_managment/core/provider/firebse_provider.dart';
import 'package:property_managment/features/booking/repository/booking_repo.dart';
import 'package:property_managment/features/notification/controllers/notification_controller.dart';
import 'package:property_managment/modelClass/bookingmodel.dart';

final bookingRepoProvider = Provider(
  (ref) => BookingRepo(ref.watch(firebaseServiceProvider),ref.watch(notificationRepositoryProvider)),
);

// ✔ StreamProvider.family because you need a booking ID
final bookingProvider = StreamProvider.family<BookingModel?, String>((ref, bookingId) {
  return ref.watch(bookingRepoProvider).getBooking(bookingId);
});
