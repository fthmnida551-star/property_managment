import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:property_managment/core/provider/firebse_provider.dart';
import 'package:property_managment/features/auth/repository/login_repository.dart';

final loginRepositoryProvider = Provider(
  (ref) => LoginRepository(ref.watch(firebaseServiceProvider)),
);