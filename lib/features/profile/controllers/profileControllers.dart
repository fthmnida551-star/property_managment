import 'dart:developer';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:property_managment/core/provider/firebse_provider.dart';
import 'package:property_managment/features/profile/repository/profile_repo.dart';
import 'package:property_managment/modelClass/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ---------------- Repository Provider ----------------

final profileRepositoryProvider = Provider(
  (ref) => ProfileRepository(ref.watch(firebaseServiceProvider)),
);

// ---------------- User Stream Provider ----------------
// Reads the userId from SharedPreferences and listens to Firestore updates.

final profileListProvider = StreamProvider.autoDispose<UserModel?>((
  ref,
) async* {
  final prefs = await SharedPreferences.getInstance();
  final userId = prefs.getString('userId') ?? "";

  log("PROFILE STREAM userId = $userId");

  final stream = ref.watch(profileRepositoryProvider).getUserData(userId);

  yield* stream;
});

// ---------------- Update Controller ----------------

class UpdateProfileController extends StateNotifier<AsyncValue<void>> {
  final ProfileRepository repository;

  UpdateProfileController(this.repository) : super(const AsyncData(null));

  Future<void> updateUser(Map<String,dynamic> user) async {
    try {
      state = const AsyncLoading(); // start loading

      await repository.saveUserData(user); // update Firestore

      state = const AsyncData(null); // success
    } catch (e, st) {
      state = AsyncError(e, st); // error
    }
  }
}

// ---------------- Provider for Controller ----------------

final updateProfileControllerProvider =
    StateNotifierProvider<UpdateProfileController, AsyncValue<void>>((ref) {
      return UpdateProfileController(ref.watch(profileRepositoryProvider));
    });

// -------------------image---------------------------
final profileImageProvider =
    StateNotifierProvider<ProfileImageNotifier, File?>(
  (ref) => ProfileImageNotifier(),
);

class ProfileImageNotifier extends StateNotifier<File?> {
  ProfileImageNotifier() : super(null);

  void setImage(File file) {
    state = file;
  }

  void clear() {
    state = null;
  }
}

