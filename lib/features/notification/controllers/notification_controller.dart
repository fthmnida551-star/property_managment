import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:property_managment/core/provider/firebse_provider.dart';
import 'package:property_managment/features/notification/repository/notification_repository.dart';

final notificationRepositoryProvider = Provider(
  (ref) => NotificationRepository(ref.watch(firebaseServiceProvider)),
);
final notificationProvider = StreamProvider(
  (ref) => ref.watch(notificationRepositoryProvider).getNotifications(),
 
);
final notificationDelete=Provider(
  (ref)=>ref.watch(notificationRepositoryProvider));
