import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:property_managment/core/provider/firebse_provider.dart';
import 'package:property_managment/features/booking/repository/booking_repo.dart';
import 'package:property_managment/features/notification/controllers/notification_controller.dart';

final bookingRepoProvider = Provider(
  (ref) => BookingRepo(ref.watch(firebaseServiceProvider),ref.watch(notificationRepositoryProvider)),
);