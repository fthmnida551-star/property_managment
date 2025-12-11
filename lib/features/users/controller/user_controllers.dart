import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:property_managment/core/provider/firebse_provider.dart';
import 'package:property_managment/features/users/repository/user_repository.dart';

// final firebaseServiceProvider = Provider((ref) => FirebaseService());

final userRepositoryProvider = Provider(
  (ref) => USersRepository(ref.watch(firebaseServiceProvider)),
);

final userListProvider = StreamProvider(
  (ref) => ref.watch(userRepositoryProvider).getAllUsersList(),
);
