import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:property_managment/core/provider/firebse_provider.dart';
import 'package:property_managment/features/booking/repository/booked_prprty_repo.dart';
import 'package:property_managment/features/booking/repository/booking_repo.dart';
import 'package:property_managment/features/notification/controllers/notification_controller.dart';
import 'package:property_managment/modelClass/bookingmodel.dart';

final bookingRepoProvider = Provider(
  (ref) => BookingRepo(ref.watch(firebaseServiceProvider),ref.watch(notificationRepositoryProvider)),
);

// ✔ StreamProvider.family because you need a booking ID
final bookingProvider = FutureProvider.family<BookingModel?, String>((ref, bookingId) async{
  return await ref.watch(bookingRepoProvider).getBooking(bookingId);
});


final bookedPropertyRepoProvider = Provider(
  (ref) => BookedPrprtyRepo(ref.watch(firebaseServiceProvider),),
);

final bookedPropertyListProvider = StreamProvider(
  (ref) => ref.watch(bookedPropertyRepoProvider).getAllBookedPropertyDetailsList(),
);
