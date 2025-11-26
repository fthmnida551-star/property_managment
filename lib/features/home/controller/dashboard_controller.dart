import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:property_managment/core/provider/firebse_provider.dart';
import 'package:property_managment/features/home/repository/dashboard_repository.dart';
import 'package:property_managment/modelClass/property_model.dart';

final dashboardRepositoryProvider=Provider(
  (ref)=>DashboardRepository(ref.watch(firebaseServiceProvider)));
  final propertyListProvider=StreamProvider(
    (ref)=>ref.watch(dashboardRepositoryProvider).getPropertyCount());
    final  bookedListProvider=StreamProvider(
      (ref)=>ref.watch(dashboardRepositoryProvider).getBookedCount());
final bookedpropertyListProvider=StreamProvider(
  (ref)=>ref.watch(dashboardRepositoryProvider).getBookedProperties());
final propertyByIdProvider = StreamProvider.family<PropertyModel?, String>((ref, propertyId) {
  return ref.watch(dashboardRepositoryProvider).getPropertyById(propertyId);
}); 